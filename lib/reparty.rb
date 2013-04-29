require "reparty/version"

require "reparty/config"
require "reparty/generator"
require "reparty/report"
require "reparty/report/active_record"

require "reparty/engine"
require "reparty/railties"

module Reparty
  class << self
    attr_accessor :configuration
    attr_reader :reports

    def config
      self.configuration = Config.new

      yield(configuration)

      @reports = self.configuration.reports
    end
  end
end
