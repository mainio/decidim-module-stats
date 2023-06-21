# frozen_string_literal: true

module Decidim
  module Stats
    # A set is group of data measurements bound to the same collection record.
    # Each set can have multiple measurements.
    class Set < Stats::ApplicationRecord
      belongs_to :collection, foreign_key: :decidim_stats_collection_id, class_name: "Decidim::Stats::Collection"
      has_many(
        :measurements,
        -> { order(:label) },
        foreign_key: :decidim_stats_set_id,
        class_name: "Decidim::Stats::Measurement",
        inverse_of: :set,
        dependent: :destroy
      )
    end
  end
end
