require 'rails_helper'

RSpec.describe Artist, :type => :model do
  REQUIRED_ATTRS = %w(name bio)

  subject do
    Artist.new \
      name: "The Wonder Bars",
      bio: "A house band from **Philadelphia**",
      avatar: files('avatar.png')
  end

  it "represents a signed artist on the label" do
    expect(subject).to be_valid
  end

  REQUIRED_ATTRS.each do |attr|
    it "must have :#{attr} set" do
      subject.send("#{attr}=", nil)
      expect(subject).to_not be_valid
    end
  end
end
