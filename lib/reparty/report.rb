module Reparty
  class Report
    attr_reader :title

    def initialize(title)
      raise "Report: title must be defined" unless title.is_a?(String) || title.empty?
      @title = title
    end
  end
end