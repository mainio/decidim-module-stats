# frozen_string_literal: true

module Decidim
  module Stats
    module StatsTypeExtension
      def self.included(type)
        type.field :stats, [Decidim::Stats::CollectionType], description: "The statistics collections for this record" do
          argument :keys, GraphQL::Types::String, "A statistics collection key to search for.", required: false
        end
      end

      def stats(keys: nil)
        user = context[:current_user]

        if user&.admin?
          query = object.stats
          query = query.where(key: keys) if keys
          query
        else
          []
        end
      end
    end
  end
end
