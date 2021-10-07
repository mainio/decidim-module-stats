# frozen_string_literal: true

require_relative "stats/version"
require_relative "stats/engine"
require_relative "stats/admin"
require_relative "stats/api"

module Decidim
  module Stats
    autoload :Aggregator, "decidim/stats/aggregator"
    autoload :Measurable, "decidim/stats/measurable"
    autoload :QueryExtensions, "decidim/stats/query_extensions"

    def self.aggregators
      @aggregators ||= []
    end

    def self.register_aggregator(aggregator_class)
      aggregators << aggregator_class
    end
  end
end
