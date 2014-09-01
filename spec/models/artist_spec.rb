require 'rails_helper'

RSpec.describe Artist, :type => :model do
  subject do
    Artist.new \
      name: "The Wonder Bars",
      bio: "A house band from Philadelphia",
      avatar: files('avatar.png')
  end

  it "represents a signed artist on the label" do
    expect(subject).to be_valid
  end

  test_validations_with %w(name bio)
end
