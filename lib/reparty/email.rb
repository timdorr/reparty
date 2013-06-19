module Reparty
  class Email
    class << self
      def reports
        Reparty.reports
      end

      def weekly_reports
        Reparty.weekly_reports
      end

      def from
        Reparty.configuration.from || 'nobody@nowhere.com'
      end

      def subject
        Reparty.configuration.subject || "Reparty Report!"
      end

      def title
        Reparty.configuration.title || 'Your Daily Report:'
      end

      def weekly_title
        Reparty.configuration.weekly_title || 'Your Weekly Report:'
      end
    end
  end
end