require 'rails_helper'

RSpec.describe Release, :type => :model do
  REQUIRED_ATTRS = %w(name released_on description catalog_number)

  subject do
    Release.new \
      name: "Falling In Love EP",
      released_on: 1.day.ago.to_date,
      description: %(
        An EP from The Wonder Bars!

        ### Track Listing

        1. Falling In Love
        2. I Love My Country
      ),
      catalog_number: "WXP003",
      cover: files('cover_image.png')
  end

  it "represents a release for sale" do
    expect(subject).to be_valid
  end

  REQUIRED_ATTRS.each do |attr|
    it "must have :#{attr} set" do
      subject.send "#{attr}=", nil
      expect(subject).to_not be_valid
    end
  end
end
