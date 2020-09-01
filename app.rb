#!/usr/bin/env ruby

# frozen_string_literal: true

require 'require_all'
require 'pry-byebug'
require 'terminal-table'

require_all 'lib'

parsed_logs = LogHandler::Parser::Csv.call(ARGV[0], col_sep: ' ') do |row, result|
  LogHandler::ViewsCounter.call(row: row, result: result)
end

total_views = LogHandler::ViewsCalculator.call(views: parsed_logs, mode: :total)
LogHandler::ViewsPresenter.call(views: total_views, mode: :total)

unique_views = LogHandler::ViewsCalculator.call(views: parsed_logs, mode: :unique)
LogHandler::ViewsPresenter.call(views: unique_views, mode: :unique)
