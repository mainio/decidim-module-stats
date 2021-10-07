# frozen_string_literal: true

module Decidim
  module Stats
    autoload :StatsInterface, "decidim/stats/api/interfaces/stats_interface"
    autoload :CollectionType, "decidim/stats/api/types/collection_type"
    autoload :MeasurementType, "decidim/stats/api/types/measurement_type"
    autoload :SetType, "decidim/stats/api/types/set_type"
    autoload :StatsTypeExtension, "decidim/stats/api/stats_type_extension"
  end
end
