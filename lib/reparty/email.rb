module Reparty
  class Email
    class << self
      def reports
        Reparty.reports
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
    end
  end
end