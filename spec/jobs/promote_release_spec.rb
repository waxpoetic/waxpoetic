require 'rails_helper'

RSpec.describe PromoteRelease, :type => :job do
  let(:release) { releases :falling_in_love }

  it "mails everyone on the subscriber list" do
    expect { PromoteRelease.perform_now release }.to \
      change { ActionMailer::Base.deliveries.count }.by(Subscriber.count)
  end
end
