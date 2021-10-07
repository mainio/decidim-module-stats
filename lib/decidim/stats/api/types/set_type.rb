# frozen_string_literal: true

module Decidim
  module Stats
    SetType = GraphQL::ObjectType.define do
      name "StatsSet"
      description "A statistics set"

      field :key, !types.String, "The key for this set"
      field :measurements, !types[Decidim::Stats::MeasurementType] do
        description "The statistics measurements for this set"
        resolve ->(obj, _args, _ctx) {
          obj.measurements.where(parent: nil)
        }
      end
    end
  end
end
