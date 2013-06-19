require "reparty/version"

require "reparty/config"
require "reparty/email"

require "reparty/report"
require "reparty/report/active_record"
require "reparty/report/sendgrid"
require "reparty/report/mixpanel"

require "reparty/engine"

module Reparty
  class << self
    def root
      Pathname.new(File.expand_path('../..', __FILE__))
    end

    attr_accessor :configuration
    attr_reader :reports, :weekly_reports

    def config
      self.configuration = Config.new

      yield(configuration)

      @reports = self.configuration.reports
      @weekly_reports = self.configuration.weekly_reports
    end
  end
end
