# frozen_string_literal: true

module Decidim
  module Stats
    module StatsTypeExtension
      def self.define(type)
        type.field :stats, !type.types[Decidim::Stats::CollectionType] do
          description "The statistics collections for this record"

          argument :keys, method_access: false do
            type types[types.String]
            description "A statistics collection key to search for."
          end

          resolve lambda { |obj, args, ctx|
            user = ctx[:current_user]

            if user&.admin?
              query = obj.stats
              query = query.where(key: args[:keys]) if args[:keys]
              query
            else
              []
            end
          }
        end
      end
    end
  end
end
