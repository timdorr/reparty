ActionMailer::Base.view_paths = File.expand_path('../../views/', __FILE__)

class ReportMailer < ActionMailer::Base
  def daily(to)
    @title = Reparty::Email.title

    @reports = Reparty::Email.reports
    @reports.each {|r| r.attach(attachments)}
    attachments.inline['spacer.gif'] = File.read(Reparty.root + 'app/assets/images/spacer.gif')

    mail(
        from: Reparty::Email.from,
        to: to,
        subject: Reparty::Email.subject
    )
  end

  def weekly(to)
    @title = Reparty::Email.weekly_title

    @reports = Reparty::Email.weekly_reports
    @reports.each {|r| r.attach(attachments)}
    attachments.inline['spacer.gif'] = File.read(Reparty.root + 'app/assets/images/spacer.gif')

    mail(
        from: Reparty::Email.from,
        to: to,
        subject: Reparty::Email.subject
    )
  end
end