require "ostruct"

module Reparty
  class Config < ::OpenStruct
    attr_reader :reports, :weekly_reports

    def initialize
      @reports = @weekly_reports = []
      super
    end

    def add_report(report, *args, &block)
      @reports << report.new(1, *args, &block)
    end

    def add_weekly_report(report, *args, &block)
      @weekly_reports << report.new(7, *args, &block)
    end
  end
end