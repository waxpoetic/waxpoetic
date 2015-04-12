require 'rails_helper'

RSpec.describe UserSubscribeJob, type: :job do
  let :subscriber do
    Subscriber.new name: 'lester tester', email: 'test@example.com'
  end

  class MockList
    attr_reader :subscribers

    def initialize
      @subscribers = []
    end

    def subscribe(params = {})
      @subscribers << params
    end
  end

  let :mock_list do
    MockList.new
  end

  before do
    allow(Subscriber).to receive(:list).and_return mock_list
  end

  context 'in production' do
    before do
      allow(WaxPoetic).to receive(:live?).and_return true
    end

    it 'subscribes a user to the mailing list' do
      expect {
        UserSubscribeJob.perform_now subscriber
      }.to change {
        Subscriber.count
      }.by 1
    end
  end

  context 'in development' do
    before do
      allow(WaxPoetic).to receive(:live?).and_return false
      UserSubscribeJob.perform_now subscriber
    end

    it 'does nothing but completes the job' do
      expect {
        UserSubscribeJob.perform_now subscriber
      }.to_not change {
        Subscriber.count
      }
    end
  end
end
