require 'gruff'

module Reparty
  class Report
    attr_reader :title, :color

    def initialize(title)
      raise "Report: title must be defined" if title.blank?
      @title = title
      @color = "#832701"
    end

    def attach(attachments)
      # Optional
    end

    protected

    def build_daily_graph
      g = Gruff::Line.new(545)
      g.title = @title
      g.labels = Hash[*(1..7).map{|x| [x-1, (DateTime.now - (8-x)).strftime("%-m/%-d")] }.flatten]
      g
    end
  end
end