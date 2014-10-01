require 'rails_helper'

RSpec.describe User, :type => :model do
  subject do
    User.new \
      email: 'admin@example.com',
      password: 'password1',
      password_confirmation: 'password1'
  end

  it "authenticates users into the admin console" do
    expect(subject).to be_valid
  end
end
