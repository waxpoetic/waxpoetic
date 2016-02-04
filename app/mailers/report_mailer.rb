class ReportMailer < ApplicationMailer
  def daily_report
    today = Time.zone.now.strftime '%M %D, %y'
    @title = "Daily report for #{today}"
    mail to: User.pluck(:email), subject: @title
  end
end
