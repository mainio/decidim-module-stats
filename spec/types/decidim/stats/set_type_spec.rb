# frozen_string_literal: true

require "spec_helper"
require "decidim/api/test/type_context"

describe Decidim::Stats::SetType do
  include_context "with a graphql class type"

  let(:model) { create(:stats_set) }

  describe "key" do
    let(:query) { "{ key }" }

    it "returns the set's key" do
      expect(response["key"]).to eq(model.key)
    end
  end

  describe "measurements" do
    let(:query) { "{ measurements { label value } }" }

    let!(:measurements) { create_list(:stats_measurement, 2, set: model) }

    it "returns the set's measurements" do
      expect(response["measurements"]).to match_array(
        measurements.map { |child| { "label" => child.label, "value" => child.value } }
      )
    end
  end
end
