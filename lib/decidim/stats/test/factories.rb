# frozen_string_literal: true

require "decidim/core/test/factories"
require "decidim/dev/test/factories"

FactoryBot.define do
  factory :stats_collection, class: "Decidim::Stats::Collection" do
    organization { measurable.organization }
    measurable { create(:dummy_resource) }
    sequence(:key) { |n| "collection_#{n}" }
    metadata { {} }
    finalized { false }

    trait :finalized do
      finalized { true }
    end
  end

  factory :stats_set, class: "Decidim::Stats::Set" do
    collection { create(:stats_collection) }
    sequence(:key) { |n| "set_#{n}" }
  end

  factory :stats_measurement, class: "Decidim::Stats::Measurement" do
    set { create(:stats_set) }
    label { generate(:title) }
    value { rand(0..100) }

    trait :with_parent do
      after(:build) do |measurement|
        set.parent = create(:stats_measurement, set: measurement.set)
      end
    end

    trait :with_children do
      after(:create) do |measurement|
        create_list(:stats_measurement, 2, set: measurement.set, parent: measurement)
      end
    end
  end
end
