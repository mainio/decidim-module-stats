# frozen_string_literal: true

module Decidim
  module Stats
    module StatsInterface
      include Decidim::Api::Types::BaseInterface
      description "This interface is implemented by any object that can have statistics."

      # Decidim::Stats::StatsTypeExtension.define(self)
    end
  end
end
