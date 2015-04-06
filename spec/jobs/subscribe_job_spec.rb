require 'rails_helper'

RSpec.describe SubscribeJob, type: :job do
  it "subscribes somone to the newsletter" do
    SubscribeJob.perform_now subscriber
    expect(subscriber).to be_persisted
  end
end
