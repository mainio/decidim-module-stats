# frozen_string_literal: true

module Decidim
  module Stats
    class MeasurementType < Decidim::Api::Types::BaseObject
      graphql_name "StatsMeasurement"
      description "A statistics measurement"

      field :label, GraphQL::Types::String, "The label for this measurement", null: false
      field :value, GraphQL::Types::Int, "The value for this measurement", null: false
      field :children, [Decidim::Stats::MeasurementType], "The child measurements for this measurement", null: false
    end
  end
end
