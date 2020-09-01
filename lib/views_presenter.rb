# frozen_string_literal: true

require 'terminal-table'
module LogHandler
  class ViewsPresenter
    ACCEPTED_MODES = %i[total unique].freeze

    def self.call(views:, mode:)
      new(views, mode).call
    end

    def initialize(views, mode)
      @views = views
      @mode = mode
    end

    def call
      raise UnacceptedModeError unless ACCEPTED_MODES.include?(mode)

      table = generate_table
      puts table
    end

    private

    attr_reader :views, :mode

    def sort_views
      views.sort { |a, b| a[1] <=> b[1] }.reverse
    end

    def generate_table
      Terminal::Table.new(
        rows: sort_views,
        headings: ['Page', "#{count_specifier.capitalize} Views"],
        title: "Report on #{count_specifier} page views"
      )
    end

    def count_specifier
      @count_specifier ||= case mode
                           when :total
                             'total'
                           when :unique
                             'unique'
                           end
    end
  end
end
