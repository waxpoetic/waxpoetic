require 'rails_helper'

RSpec.describe ReleaseProduct, :type => :product do
  let(:release) { releases :just_the_start_ep }
  subject { ReleaseProduct.new(release) }

  it "builds metadata fields for catalog number and release date" do
    property_names = subject.metadata.map do |key, hash|
      hash[:property_name]
    end

    expect(property_names).to include('Catalog Number')
    expect(property_names).to include('Release Date')
  end

  it "uses the title of the release as a name" do
    expect(subject.name).to eq(release.decorate.title)
  end

  it "uses the full description of the release as a description" do
    expect(subject.description).to eq(release.decorate.full_description)
  end

  it "uses the released_on Date as the date at which it's available for purchase" do
    expect(subject.available_on).to eq(release.decorate.released_on)
  end
end
