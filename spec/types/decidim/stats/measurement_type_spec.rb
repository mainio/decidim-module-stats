# frozen_string_literal: true

require "spec_helper"
require "decidim/api/test/type_context"

describe Decidim::Stats::MeasurementType do
  include_context "with a graphql type"

  let(:model) { create(:stats_measurement) }

  describe "label" do
    let(:query) { "{ label }" }

    it "returns the measurement's label" do
      expect(response["label"]).to eq(model.label)
    end
  end

  describe "value" do
    let(:query) { "{ value }" }

    it "returns the measurement's value" do
      expect(response["value"]).to eq(model.value)
    end
  end

  describe "children" do
    let(:query) { "{ children { label value } }" }

    let!(:children) { create_list(:stats_measurement, 2, parent: model) }

    it "returns the measurement's children" do
      expect(response["children"]).to match_array(
        children.map { |child| { "label" => child.label, "value" => child.value } }
      )
    end
  end
end
