require 'rails_helper'

RSpec.describe Release, :type => :model do
  let(:wonder_bars) { artists :wonder_bars }

  subject do
    Release.new \
      name: "Falling In Love EP",
      artist: wonder_bars,
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

  test_validations_with %w(name released_on description catalog_number)

  it "represents a release for sale" do
    expect(subject).to be_valid
  end
end
