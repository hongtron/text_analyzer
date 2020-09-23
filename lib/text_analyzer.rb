require "fileutils"
require "logger"

require "text_analyzer/analyzer"
require "text_analyzer/version"

module TextAnalyzer
  LOGGER = Logger.new(STDOUT)
  DEFAULT_SORT_ORDER = "descending"
  SORT_ORDERS = [DEFAULT_SORT_ORDER, "ascending"]

  class << self
    LOGGER.level = Logger::WARN

    def sort_order
      order = ENV["SORT_ORDER"]
      if SORT_ORDERS.include?(order)
        order
      else
        LOGGER.warn("Unrecognized sort order: #{order}; defaulting to #{DEFAULT_SORT_ORDER}.")
        DEFAULT_SORT_ORDER
      end
    end

    def debug?
      ENV["DEBUG"] == "true"
    end
  end
end

if TextAnalyzer.debug?
  require "pry-byebug"
  Thread.abort_on_exception = true
  TextAnalyzer::LOGGER.level = Logger::DEBUG
end
