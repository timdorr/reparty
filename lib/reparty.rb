require "reparty/version"

require "reparty/config"
require "reparty/report"
require "reparty/report/active_record"
require "reparty/email"

require "reparty/engine"

module Reparty
  class << self
    def root
      Pathname.new(File.expand_path('../..', __FILE__))
    end

    attr_accessor :configuration
    attr_reader :reports

    def config
      self.configuration = Config.new

      yield(configuration)

      @reports = self.configuration.reports
    end
  end
end
