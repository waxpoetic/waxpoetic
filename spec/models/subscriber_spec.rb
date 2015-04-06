# == Schema Information
#
# Table name: subscribers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe Subscriber, :type => :model do
  subject { Subscriber.new name: 'example', email: 'user@example.com' }

  it "represents a person who wants to know when releases happen" do
    expect(subject).to be_valid
  end

  test_validations_for %w(email)

  it "must have a valid email" do
    subject.email = 'not a real email'

    expect(subject).to_not be_valid
  end

  it "subscribes the user to the mailing list" do
    allow(SubscribeJob).to receive(:perform_later).and_return true
    expect(subject.save).to eq(true)
  end
end
