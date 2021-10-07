# frozen_string_literal: true

module Decidim
  module Stats
    # Defines the base class for data aggregators.
    class Aggregator
      def run
        raise NotImplementedError
      end

      protected

      attr_reader :context
    end
  end
end
