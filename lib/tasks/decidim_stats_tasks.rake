# frozen_string_literal: true

namespace :decidim do
  namespace :stats do
    # Run all the registered stats aggregators.
    desc "Execute all metrics calculation methods"
    task aggregate: :environment do
      Decidim::Stats.aggregators.each do |aggregator|
        aggregator.new.run
      end
    end
  end
end
