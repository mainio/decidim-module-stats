# frozen_string_literal: true

module Decidim
  module Stats
    MeasurementType = GraphQL::ObjectType.define do
      name "StatsMeasurement"
      description "A statistics measurement"

      field :label, !types.String, "The label for this measurement"
      field :value, !types.Int, "The value for this measurement"
      field :children, !types[Decidim::Stats::MeasurementType], "The child measurements for this measurement"
    end
  end
end
