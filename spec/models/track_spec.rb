# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  release_id :integer
#  price      :decimal(19, 2)
#  created_at :datetime
#  updated_at :datetime
#  file       :string(255)
#  number     :integer
#  short_url  :string(255)
#  product_id :integer
#
# Indexes
#
#  index_tracks_on_product_id  (product_id)
#  index_tracks_on_release_id  (release_id)
#

require 'rails_helper'

RSpec.describe Track, :type => :model do
  let(:artist) { artists :the_wonder_bars }
  let(:release) { releases :just_the_start_ep }

  subject do
    Track.new \
      name: "Falling In Love",
      artist: artist,
      release: release,
      price: 1.49
  end

  test_validations_with %w(name artist release)

  it "automatically sets the price" do
    subject.price = nil
    expect(subject).to be_valid
    expect(subject.price).to eq(Track::DEFAULT_PRICE)
  end
end
