module Reparty
  class ReportMailer < ActionMailer::Base
    def daily(address)
      mail(
          to: address,
          subject: "Report!"
      )
    end
  end
end