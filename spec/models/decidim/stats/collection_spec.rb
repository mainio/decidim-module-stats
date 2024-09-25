# frozen_string_literal: true

require "spec_helper"

describe Decidim::Stats::Collection do
  subject { create(:stats_collection) }

  describe ".process!" do
    let(:organization) { create(:organization) }
    let(:participatory_space) { create(:participatory_process, organization:) }
    let(:measurable) { create(:component, manifest_name: "dummy", participatory_space:) }
    let(:conditions) { { organization:, metadata: {}, key: "test" } }

    it "yields by default" do
      expect { |b| measurable.stats.process!(**conditions, &b) }.to yield_control
    end

    it "sets the collection locked during the yield" do
      b = ->(collection) { expect(collection.locked_at).not_to be_nil }

      measurable.stats.process!(**conditions, &b)

      collection = measurable.stats.find_by(**conditions)
      expect(collection.locked_at).to be_nil
    end

    context "when the collection is locked" do
      let!(:collection) { measurable.stats.create!(locked_at: Time.current, **conditions) }

      it "does not yield" do
        expect { |b| measurable.stats.process!(**conditions, &b) }.not_to yield_control
      end
    end

    context "when the collection is finalized" do
      let!(:collection) { measurable.stats.create!(finalized: true, **conditions) }

      it "does not yield" do
        expect { |b| measurable.stats.process!(**conditions, &b) }.not_to yield_control
      end
    end
  end

  describe "#finalize!" do
    it "sets the finalized at field" do
      expect { subject.finalize! }.to change(subject, :finalized?).from(false).to(true)
    end
  end

  describe "#available?" do
    it "returns true by default" do
      expect(subject.available?).to be(true)
    end

    context "when the collection is finalized" do
      before { subject.update!(finalized: true) }

      it "returns false" do
        expect(subject.available?).to be(false)
      end
    end

    context "when the collection is locked" do
      before { subject.update!(locked_at: Time.current) }

      it "returns false" do
        expect(subject.available?).to be(false)
      end
    end
  end

  describe "#locked?" do
    it "returns false by default" do
      expect(subject.locked?).to be(false)
    end

    context "when the locked_at field is set to a value" do
      before { subject.update!(locked_at: Time.current) }

      it "returns true" do
        expect(subject.locked?).to be(true)
      end
    end
  end

  describe "#lock!" do
    it "sets the locked_at to the collection" do
      expect(subject.locked_at).to be_nil
      expect { subject.lock! }.to change(subject, :locked_at)
      expect(subject.locked_at).not_to be_nil
    end
  end

  describe "#unlock!" do
    before { subject.update!(locked_at: Time.current) }

    it "unsets the locked_at to the collection" do
      expect(subject.locked_at).not_to be_nil
      expect { subject.unlock! }.to change(subject, :locked_at)
      expect(subject.locked_at).to be_nil
    end
  end
end
