require "ostruct"

module Reparty
  class Config < ::OpenStruct
    attr_reader :reports

    def initialize
      @reports = []
      super
    end

    def add_report(report, *args, &block)
      @reports << report.new(*args, &block)
    end
  end
end