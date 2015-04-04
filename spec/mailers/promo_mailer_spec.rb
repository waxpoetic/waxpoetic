require "rails_helper"

RSpec.describe PromoMailer, :type => :mailer do
  let(:release) { releases :just_the_start_ep }
  let(:subscriber) { subscribers :example }

  it "sends the new release email" do
    mail = PromoMailer.new_release(subscriber, release).deliver_now
    mail_subject = "'#{release.decorate.title}' just dropped on Wax Poetic!"
    expect(mail).to have_subject(mail_subject)
    expect(mail).to have_body_text('just released something!')
    expect(mail).to deliver_to(subscriber.decorate.address)
    expect(mail).to deliver_from(PromoMailer::FROM_EMAIL)
  end
end
