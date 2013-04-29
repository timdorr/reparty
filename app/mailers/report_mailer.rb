ActionMailer::Base.view_paths = File.expand_path('../../views/', __FILE__)

class ReportMailer < ActionMailer::Base
  def daily(address)

    @reports = Reparty::Generator.reports

    mail(
        to: address,
        subject: "Report!"
    )
  end
end