# frozen_string_literal: true

module Decidim
  module Stats
    # This is an engine that controls the stats functionality.
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::Stats

      initializer "decidim_stats.type_extensions" do
        # TODO: Update to 0.24+
        Decidim::Core::ComponentInterface.define do
          Decidim::Stats::StatsTypeExtension.define(self)
        end
      end

      config.to_prepare do
        # Model extensions
        Decidim::Component.include(Decidim::Stats::Measurable)
      end
    end
  end
end
