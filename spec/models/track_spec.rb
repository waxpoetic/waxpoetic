require 'rails_helper'

RSpec.describe Track, :type => :model do
  let(:wonder_bars) { artists :wonder_bars }
  let(:falling_in_love) { releases :falling_in_love }

  subject do
    Track.new \
      name: "Falling In Love",
      artist: wonder_bars,
      release: falling_in_love,
      price: 1.49
  end

  test_validations_with %w(name artist release)

  it "automatically sets the price" do
    subject.price = nil
    expect(subject).to be_valid
    expect(subject.price).to eq(Track::DEFAULT_PRICE)
  end
end
