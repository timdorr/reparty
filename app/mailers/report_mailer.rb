class ReportMailer < ActionMailer::Base
  def daily(address)

    @reports = Reparty::Generator.reports

    mail(
        to: address,
        subject: "Report!"
    )
  end
end