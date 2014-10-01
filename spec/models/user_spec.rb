require 'rails_helper'

RSpec.describe User, :type => :model do
  subject do
    User.new \
      email: 'user@example.com',
      password: 'password1',
      password_confirmation: 'password1'
  end

  it "authenticates users into the admin console" do
    expect(subject).to be_valid
  end

  it "is not an admin by default" do
    expect(subject).to_not be_admin
  end

  it "can have admin rights changed on it" do
    subject.is_admin = true
    expect(subject).to be_admin
  end
end
