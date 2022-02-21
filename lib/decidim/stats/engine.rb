# frozen_string_literal: true

module Decidim
  module Stats
    # This is an engine that controls the stats functionality.
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::Stats

      initializer "decidim_stats.type_extensions" do
        Decidim::Core::ComponentInterface.include Decidim::Stats::StatsTypeExtension
      end

      config.to_prepare do
        # Model extensions
        Decidim::Component.include(Decidim::Stats::Measurable)
      end
    end
  end
end
