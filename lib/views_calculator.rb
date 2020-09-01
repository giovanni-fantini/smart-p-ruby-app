# frozen_string_literal: true

module LogHandler
  class UnacceptedModeError < StandardError; end
  class ViewsCalculator
    ACCEPTED_MODES = %i[total unique].freeze

    def self.call(views:, mode:)
      new(views, mode).call
    end

    def initialize(views, mode)
      @views = views
      @mode = mode
    end

    def call
      unless ACCEPTED_MODES.include?(mode)
        raise UnacceptedModeError, "The specified mode is invalid - currently accepted modes #{ACCEPTED_MODES}"
      end

      count_views
    end

    private

    attr_reader :views, :mode

    def count_views
      views.map do |page, ip_views|
        view_count = count_views_per_ip(ip_views)
        [page, view_count]
      end
    end

    def count_views_per_ip(ip_views)
      case mode
      when :total
        ip_views.map { |_, views| views }.reduce(0, :+)
      when :unique
        ip_views.length
      end
    end
  end
end
