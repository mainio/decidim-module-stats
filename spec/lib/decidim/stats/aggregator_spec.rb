# frozen_string_literal: true

require "spec_helper"

describe Decidim::Stats::Aggregator do
  let(:aggregator) { described_class.new }

  describe "#run" do
    subject { aggregator.run }

    it "raises a NotImplementedError" do
      expect { subject }.to raise_error(NotImplementedError)
    end
  end

  describe "#context" do
    subject { aggregator.test_context }

    let(:aggregator_class) do
      Class.new(described_class) do
        def initialize
          @context = { foo: :bar }
        end

        def test_context
          context
        end
      end
    end
    let(:aggregator) { aggregator_class.new }

    it "fetches the context" do
      expect(subject).to eq(foo: :bar)
    end
  end
end
