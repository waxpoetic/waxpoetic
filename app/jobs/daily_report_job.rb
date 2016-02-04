class DailyReportJob < ActiveJob::Base
  queue_as :reports

  def perform
    ReportMailer.daily_report.deliver_later
  end
end
