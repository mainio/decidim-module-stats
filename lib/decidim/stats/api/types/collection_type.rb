# frozen_string_literal: true

module Decidim
  module Stats
    CollectionType = GraphQL::ObjectType.define do
      name "StatsCollection"
      description "A statistics collection"

      field :key, types.String, "The key for this collection"
      field :metadata, GraphQL::Types::JSON, "The metadata for this collection"
      field :lastValueAt, Decidim::Core::DateTimeType, "The time when the last value was included in this collection", property: :last_value_at
      field :sets, !types[Decidim::Stats::SetType] do
        description "The statistics sets for this collection"

        argument :keys, method_access: false do
          type types[types.String]
          description "A statistics set key to search for."
        end

        resolve lambda { |obj, args, _ctx|
          query = obj.sets
          query = query.where(key: args[:keys]) if args[:keys]
          query
        }
      end
    end
  end
end
