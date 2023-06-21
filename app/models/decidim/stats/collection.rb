# frozen_string_literal: true

module Decidim
  module Stats
    # A collection is a data measurement set collection bound to a measurable
    # record within Decidim. Each collection can have multiple data sets.
    class Collection < Stats::ApplicationRecord
      belongs_to :organization,
                 foreign_key: :decidim_organization_id,
                 class_name: "Decidim::Organization"
      belongs_to :measurable, foreign_key: :decidim_measurable_id, foreign_type: :decidim_measurable_type, polymorphic: true
      has_many :sets, foreign_key: :decidim_stats_collection_id, class_name: "Decidim::Stats::Set", inverse_of: :collection, dependent: :destroy
    end
  end
end
