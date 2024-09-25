# frozen_string_literal: true

module Decidim
  module Stats
    class CollectionType < Decidim::Api::Types::BaseObject
      graphql_name "StatsCollection"
      description "A statistics collection"

      field :key, GraphQL::Types::String, "The key for this collection", null: false
      field :metadata, GraphQL::Types::JSON, "The metadata for this collection", null: false
      field :last_value_at, Decidim::Core::DateTimeType, "The time when the last value was included in this collection", null: true
      field :sets, [Decidim::Stats::SetType], description: "A statistics collection", null: false do
        argument :keys, GraphQL::Types::String, description: "A statistics set key to search for.", required: false
      end

      def sets(keys: nil)
        query = object.sets
        query = query.where(key: keys) if keys
        query
      end
    end
  end
end
