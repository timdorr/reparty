ActionMailer::Base.view_paths = File.expand_path('../../views/', __FILE__)

class ReportMailer < ActionMailer::Base
  def daily(to)

    @reports = Reparty::Email.reports

    mail(
        from: Reparty::Email.from,
        to: to,
        subject: Reparty::Email.subject
    )
  end
end