# frozen_string_literal: true

module LogHandler
  class ViewsCounter
    def self.call(row:, result:)
      new(row, result).call
    end

    def initialize(row, result)
      @row = row
      @result = result
    end

    def call
      count_page_views
      result
    end

    private

    attr_reader :row, :result

    def count_page_views
      result.key?(page) ? count_visits_by_ip_address : set_first_page_view
    end

    def count_visits_by_ip_address
      result[page].key?(ip_address) ? result[page][ip_address] += 1 : result[page][ip_address] = 1
    end

    def set_first_page_view
      result[page] = { ip_address => 1 }
    end

    def page
      @page ||= row[0]
    end

    def ip_address
      @ip_address ||= row[1]
    end
  end
end
