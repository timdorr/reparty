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
    end
  end
end