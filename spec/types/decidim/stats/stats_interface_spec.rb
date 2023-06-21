# frozen_string_literal: true

require "spec_helper"
require "decidim/api/test/type_context"

describe Decidim::Stats::StatsInterface, type: :graphql do
  # include_context "with a graphql class type"
  include_context "with a graphql type"

  let(:type_class) { Decidim::Core::ComponentType }
  let(:model) { create(:dummy_component) }
  let(:collections) { create_list(:stats_collection, 5, measurable: model, organization: model.organization) }
  let!(:sets) { collections.map { |c| create_list(:stats_set, 2, collection: c) }.flatten }
  let!(:measurements) { sets.map { |s| create_list(:stats_measurement, 3, set: s) }.flatten }

  describe "stats" do
    let(:query) do
      %(
        {
          stats {
            key
            metadata
            lastValueAt
            sets {
              key
              measurements {
                label
                value
                children {
                  label
                  value
                }
              }
            }
          }
        }
      )
    end

    before do
      create_list(:stats_measurement, 2, parent: measurements[0])

      model.update!(stats: collections)
    end

    context "with no user" do
      let!(:current_user) { nil }

      it "returns an empty array" do
        expect(response["stats"]).to eq([])
      end
    end

    context "with a reguler user" do
      let!(:current_user) { create(:user, :confirmed, organization: current_organization) }

      it "returns an empty array" do
        expect(response["stats"]).to eq([])
      end
    end

    context "with admin user" do
      let!(:current_user) { create(:user, :confirmed, :admin, organization: current_organization) }

      it "returns the stats" do
        expect(response["stats"]).to match_array(
          collections.map do |collection|
            {
              "key" => collection.key,
              "metadata" => {},
              "lastValueAt" => nil,
              "sets" =>
                collection.sets.map do |set|
                  {
                    "key" => set.key,
                    "measurements" => set.measurements.map do |measurement|
                      {
                        "label" => measurement.label,
                        "value" => measurement.value,
                        "children" => measurement.children.map do |child|
                          {
                            "label" => child.label,
                            "value" => child.value
                          }
                        end
                      }
                    end
                  }
                end
            }
          end
        )
      end
    end
  end
end
