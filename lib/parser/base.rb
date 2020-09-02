# frozen_string_literal: true

module LogHandler
  module Parser
    class Base
      def self.call(filepath, opts = {}, &block)
        new(filepath, opts).call(&block)
      end

      def initialize(filepath, _opts)
        raise ArgumentError, "No file found at path #{filepath}" unless File.exist?(filepath)

        @file = filepath
      end

      def call(&block)
        raise NotImplementedError
      end

      private

      attr_reader :file
    end
  end
end
