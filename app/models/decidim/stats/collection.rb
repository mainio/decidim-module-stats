# frozen_string_literal: true

module Decidim
  module Stats
    # A collection is a data measurement set collection bound to a measurable
    # record within Decidim. Each collection can have multiple data sets.
    class Collection < Stats::ApplicationRecord
      belongs_to :organization,
                 foreign_key: :decidim_organization_id,
                 class_name: "Decidim::Organization"
      belongs_to :measurable, foreign_key: :decidim_measurable_id, foreign_type: :decidim_measurable_type, polymorphic: true
      has_many :sets, foreign_key: :decidim_stats_collection_id, class_name: "Decidim::Stats::Set", inverse_of: :collection, dependent: :destroy

      # A block method that locks the collection during the data aggregation and
      # unlocks it after the given block has been processed.
      #
      # When adding data to a collection, it should always happen within the
      # block given to this method. Otherwise it is possible that multiple
      # processes are adding data to the same collection at the same time.
      #
      # @raise [ActiveRecord::RecordInvalid] If the collection cannot be locked
      #   or unlocked due to it being invalid.
      # @return [Boolean] A boolean indicating if collection was unlocked after
      #   processing the block.
      def self.process!(**conditions)
        collection = find_or_create_by(**conditions)
        return unless collection.available?

        collection.lock!
        collection.transaction do
          yield collection
          collection.unlock!
        end
      rescue ActiveRecord::RecordNotUnique
        # This can happen if two processes try to create the same collection
        # exactly at the same time.
      end

      # Finalizes the collection meaning after finalized, it will no longer
      # receive any new values.
      #
      # @raise [ActiveRecord::RecordInvalid] If the collection cannot be locked
      #   or unlocked due to it being invalid.
      # @return [Boolean] A boolean indicating if collection was unlocked after
      #   processing the block.
      def finalize!
        update!(finalized: true)
      end

      # Defines if the collection is available for receiving data. If the
      # collection is finalized or locked, it is not available for new data.
      #
      # @return [Boolean] A boolean indicating if the collection is available
      #   to receive data.
      def available?
        !finalized? && !locked?
      end

      # Locked is a collection flag which defines that the collection is
      # currently being modified, so it should not recieve data from multiple
      # processes at the same time.
      #
      # @return [Boolean] A boolean indicating if the collection is locked.
      def locked?
        self.locked_at = self.class.where(id: id).pick(:locked_at)
        locked_at.present?
      end

      # Locks the collection.
      #
      # Note that this works differently from
      # `ActiveRecord::Locking::Pessimistic` because we want the record to be
      # available but report that it is locked, so that it is not blocking the
      # thread.
      #
      # @raise [ActiveRecord::RecordInvalid] If the collection cannot be locked
      #   due to it being invalid.
      # @return [Boolean] A boolean indicating if locking was successful.
      def lock!
        update!(locked_at: Time.current)
      end

      # Unlocks the collection.
      #
      # @raise [ActiveRecord::RecordInvalid] If the collection cannot be
      #   unlocked due to it being invalid.
      # @return [Boolean] A boolean indicating if unlocking was successful.
      def unlock!
        update!(locked_at: nil)
      end
    end
  end
end
