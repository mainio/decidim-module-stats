# frozen_string_literal: true

module Decidim
  module Stats
    module Admin
      # This is the engine that runs on the admin interface of `decidim-stats`.
      class Engine < ::Rails::Engine
        isolate_namespace Decidim::Stats::Admin

        paths["db/migrate"] = nil
        paths["lib/tasks"] = nil

        # routes do
        # end

        # initializer "decidim_stats_admin.mount_routes", before: "decidim_admin.mount_routes" do
        #   # Mount the engine routes to Decidim::Core::Engine because otherwise
        #   # they would not get mounted properly.
        #   Decidim::Admin::Engine.routes.append do
        #     mount Decidim::Stats::Admin::Engine => "/"
        #   end
        # end

        # initializer "decidim_stats_admin.admin_menu" do
        #   Decidim.menu :admin_menu do |menu|
        #     menu.item I18n.t("menu.stats", scope: "decidim.stats.admin"),
        #               decidim_stats_admin.stats_path,
        #               icon_name: "bar-chart",
        #               position: 7.1,
        #               active: :inclusive,
        #               if: allowed_to?(:update, :organization, organization: current_organization)
        #   end
        # end
      end
    end
  end
end
