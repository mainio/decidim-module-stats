# frozen_string_literal: true

module Decidim
  module Stats
    class MeasurementType < Decidim::Api::Types::BaseObject
      graphql_name "StatsMeasurement"
      description "A statistics measurement"

      field :label, GraphQL::Types::String, "The label for this measurement"
      field :value, GraphQL::Types::Int, "The value for this measurement"
      field :children, [Decidim::Stats::MeasurementType], "The child measurements for this measurement"
    end
  end
end
