# frozen_string_literal: true

module Decidim
  module Stats
    StatsInterface = GraphQL::InterfaceType.define do
      name "StatsInterface"
      description "This interface is implemented by any object that can have statistics."

      Decidim::Stats::StatsTypeExtension.define(self)
    end
  end
end
