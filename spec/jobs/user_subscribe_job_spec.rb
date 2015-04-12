require 'rails_helper'

RSpec.describe UserSubscribeJob, type: :job do
  let :subscriber do
    Subscriber.new name: 'lester tester', email: 'test@example.com'
  end

  subject { UserSubscribeJob }

  xit 'subscribes someone to the mailing list in production' do
    allow(WaxPoetic).to receive(:live?).and_return true
    expect(subject.perform_now(subscriber)).to eq(true)
    expect(subscribers.count).to change_by(1)
  end

  xit 'does nothing in development' do
    allow(WaxPoetic).to receive(:live?).and_return false
    expect(subject.perform_now(subscriber)).to eq(true)
    expect(subscribers.count).not_to change_by(1)
  end
end
