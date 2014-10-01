require 'rails_helper'

RSpec.describe Subscriber, :type => :model do
  subject { Subscriber.new name: 'example', email: 'user@example.com' }

  it "represents a person who wants to know when releases happen" do
    expect(subject).to be_valid
  end

  test_validations_with %w(name email)

  it "must have a valid email" do
    subject.email = 'not a real email'

    expect(subject).to_not be_valid
  end

  it "must have a unique email" do
    subject.email = subscribers(:example).email

    expect(subject).to_not be_valid
  end
end
