require 'rails_helper'

RSpec.describe ReportMailer, type: :mailer do
  it 'delivers daily report' do
    expect(ReportMailer.daily_report.deliver_later).to be true
    expect(ActionMailer.messages.delivered).to change_by(1)
    expect(ActionMailer.messages.enqueued).to change_by(1)
  end
end
