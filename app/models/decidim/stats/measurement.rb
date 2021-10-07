# frozen_string_literal: true

module Decidim
  module Stats
    # A measurement is the record that contains the statistics measurement
    # numbers bound to a set of measurements. The measurement can have children
    # which are sub-measurements of the same measurement.
    class Measurement < Stats::ApplicationRecord
      belongs_to :set, foreign_key: :decidim_stats_set_id, class_name: "Decidim::Stats::Set"
      belongs_to :parent, class_name: "Decidim::Stats::Measurement", inverse_of: :children, optional: true
      has_many :children, foreign_key: :parent_id, class_name: "Decidim::Stats::Measurement", inverse_of: :parent, dependent: :destroy

      validates :set, presence: true
    end
  end
end
