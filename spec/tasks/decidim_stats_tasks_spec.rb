# frozen_string_literal: true

require "spec_helper"

describe "Executing Decidim Stats tasks" do
  describe "rake decidim:stats:aggregate", type: :task do
    let(:aggregator_class) { double }
    let(:aggregator) { double }

    before do
      Decidim::Stats.register_aggregator aggregator_class

      allow(aggregator_class).to receive(:new).and_return(aggregator)
      allow(aggregator).to receive(:run) do
        collection = create(:stats_collection)
        create_list(:stats_set, 2, collection:).each do |set|
          create_list(:stats_measurement, 3, set:)
        end
      end
    end

    after do
      Decidim::Stats.remove_instance_variable(:@aggregators)
    end

    context "when executing task" do
      it "aggregates the stats" do
        expect { Rake::Task[:"decidim:stats:aggregate"].invoke }
          .to change(Decidim::Stats::Collection, :count)
          .by(1)
          .and change(Decidim::Stats::Set, :count)
          .by(2)
          .and change(Decidim::Stats::Measurement, :count)
          .by(6)
      end
    end
  end
end
