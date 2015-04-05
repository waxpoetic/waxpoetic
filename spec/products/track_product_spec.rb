require 'rails_helper'

RSpec.describe TrackProduct, :type => :product do
  let(:track) { tracks :after_hours }
  subject { TrackProduct.new(track) }

  it "uses the decorator title as a name" do
    expect(subject.name).to eq(track.decorate.title)
  end

  it "uses the release date of the release this track is on for the available on date" do
    expect(subject.available_on).to eq(track.decorate.release_date)
  end

  it "builds metadata fields for catalog number and release date" do
    property_names = subject.metadata.map do |hash|
      hash[:property].name
    end

    expect(property_names).to include('Catalog Number')
    expect(property_names).to include('Release Date')
  end
end
