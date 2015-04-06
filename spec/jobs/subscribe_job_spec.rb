require 'rails_helper'

RSpec.describe SubscribeJob, type: :job do
  let :subscriber do
    Subscriber.new name: 'test', email: 'test@example.com'
  end

  class MockList
    def initialize
      @subscribers = []
    end

    def id
      1
    end

    def subscribe(options)
      @subscribers << options
    end

    def members
      @subscribers.map do |subscriber|
        { email: subscriber[:email][:email] }
      end
    end
  end

  before do
    allow(subscriber).to receive(:list).and_return MockList.new
  end

  it "subscribes somone to the newsletter" do
    SubscribeJob.perform_now subscriber
    expect(subscriber).to be_persisted
  end
end
