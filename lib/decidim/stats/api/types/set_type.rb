# frozen_string_literal: true

module Decidim
  module Stats
    class SetType < Decidim::Api::Types::BaseObject
      graphql_name "StatsSet"
      description "A statistics set"

      field :key, GraphQL::Types::String, "The key for this set", null: false
      field :measurements, [Decidim::Stats::MeasurementType], description: "The statistics measurements for this set", null: false

      def measurements
        object.measurements.where(parent: nil)
      end
    end
  end
end
