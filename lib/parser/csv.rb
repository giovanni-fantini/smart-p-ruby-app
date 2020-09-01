# frozen_string_literal: true

require 'csv'

module LogHandler
  module Parser
    class Csv < Base
      DEFAULT_SEPARATOR = ' '

      def initialize(filepath, opts)
        super
        @col_sep = opts[:col_sep] || DEFAULT_SEPARATOR
      end

      def call(&block)
        block_given? ? parse_with_block(&block) : standard_parse
      end

      private

      attr_reader :file, :col_sep

      def parse_with_block
        result = {}

        CSV.foreach(file, col_sep: col_sep) do |row|
          result = yield(row, result)
        end

        result
      end

      def standard_parse
        CSV.read(file, col_sep: col_sep)
      end
    end
  end
end
