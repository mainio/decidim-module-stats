# frozen_string_literal: true

module Decidim
  module Stats
    # A concern that needs to be included in all records that need stats.
    module Measurable
      extend ActiveSupport::Concern

      included do
        has_many :stats,
                 as: :measurable,
                 foreign_key: :decidim_measurable_id,
                 foreign_type: :decidim_measurable_type,
                 class_name: "Decidim::Stats::Collection",
                 dependent: :destroy
      end
    end
  end
end
