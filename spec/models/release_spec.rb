# == Schema Information
#
# Table name: releases
#
#  id                  :integer          not null, primary key
#  name                :string(255)
#  artist_id           :integer
#  released_on         :datetime
#  image               :string(255)
#  description         :text
#  catalog_number      :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  price               :decimal(19, 2)
#  file                :string(255)
#  product_id          :integer
#  slug                :string(255)
#  open_source_package :string(255)
#
# Indexes
#
#  index_releases_on_artist_id   (artist_id)
#  index_releases_on_product_id  (product_id)
#

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
      catalog_number: "WXP999",
      image: files('image_image.png')
  end

  test_validations_with %w(
    name
    released_on
    description
    catalog_number
  )

  it "represents a release for sale" do
    expect(subject).to be_valid
  end

  it "must have a unique catalog number" do
    subject.catalog_number = wonder_bars.releases.first.catalog_number
    expect(subject).to_not be_valid
  end

  it "exposes certain attributes to create a Spree::Product" do
    expect(subject.product_attributes).to be_present
    expect(subject.product_attributes.keys).to eq(%w(
      name
      description
      meta_description
      available_on
      shipping_category
      price
    ))
  end

  it "should use the default shipping category" do
    expect(subject.shipping_category).to be_present
    expect(subject.shipping_category.name).to eq('Default')
  end
end
