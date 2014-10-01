require "rails_helper"

RSpec.describe PromoMailer, :type => :mailer do
  let(:release) { releases :falling_in_love }
  let(:subscriber) { subscribers :example }

  it "sends the new release email" do
    mail = PromoMailer.new_release(subscriber, release).deliver
    mail_subject = "'#{release.decorate.title}' just dropped on Wax Poetic!"
    expect(mail).to have_subject(mail_subject)
    expect(mail).to have_body_text('New Release')
    expect(mail).to deliver_to(subscriber.decorate.address)
    expect(mail).to deliver_from(PromoMailer::FROM_EMAIL)
  end
end
