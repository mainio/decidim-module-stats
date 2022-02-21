# frozen_string_literal: true

module Decidim
  module Stats
    class SetType < Decidim::Api::Types::BaseObject
      graphql_name "StatsSet"
      description "A statistics set"

      field :key, GraphQL::Types::String, "The key for this set"
      field :measurements, [Decidim::Stats::MeasurementType], description: "The statistics measurements for this set"

      def measurements
        object.measurements.where(parent: nil)
      end
    end
  end
end
