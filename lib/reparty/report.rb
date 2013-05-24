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

    def build_daily_line_graph(start_date=DateTime.now.utc)
      build_daily_graph(Gruff::Line.new(545), start_date)
    end

    def build_daily_area_graph(start_date=DateTime.now.utc)
      build_daily_graph(Gruff::Area.new(545), start_date)
    end

    def build_daily_bar_graph(start_date=DateTime.now.utc)
      build_daily_graph(Gruff::Bar.new(545), start_date)
    end

    def build_daily_graph(g, start_date)
      g.title = @title
      g.labels = Hash[*(1..7).map{|x| [x-1, (start_date - (8-x)).strftime("%-m/%-d")] }.flatten]
      g
    end
  end
end