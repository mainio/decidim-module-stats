# frozen_string_literal: true

require "spec_helper"
require "decidim/api/test/type_context"

describe Decidim::Stats::CollectionType do
  include_context "with a graphql class type"

  let(:model) { create(:stats_collection) }

  describe "key" do
    let(:query) { "{ key }" }

    it "returns the collection's key" do
      expect(response["key"]).to eq(model.key)
    end
  end

  describe "metadata" do
    let(:model) { create(:stats_collection, metadata: { foo: "bar" }) }

    let(:query) { "{ metadata }" }

    it "returns the collection's metadata" do
      expect(response["metadata"]).to eq("foo" => "bar")
    end
  end

  describe "lastValueAt" do
    let(:model) { create(:stats_collection, last_value_at: Time.current) }

    let(:query) { "{ lastValueAt }" }

    it "returns the collection's lastValueAt" do
      expect(response["lastValueAt"]).to eq(model.last_value_at.to_time.iso8601)
    end
  end

  describe "sets" do
    let(:query) { "{ sets { measurements { label value } } }" }

    let!(:sets) { create_list(:stats_set, 2, collection: model) }
    let!(:measurements) { sets.map { |s| create_list(:stats_measurement, 3, set: s) }.flatten }

    it "returns the collection's sets" do
      expect(response["sets"]).to match_array(
        sets.map do |set|
          {
            "measurements" =>
              set.measurements.map { |measurement| { "label" => measurement.label, "value" => measurement.value } }
          }
        end
      )
    end
  end
end
