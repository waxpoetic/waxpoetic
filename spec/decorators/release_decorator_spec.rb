require 'rails_helper'

RSpec.describe ReleaseDecorator, :type => :decorator do
  let(:release) { releases :falling_in_love }
  subject { ReleaseDecorator.new release }

  it "renders title from artist and name" do
    expect(subject.title).to eq("#{subject.artist.name} - #{subject.name}")
  end

  it "calculates a filename" do
    expect(subject.filename).to eq(subject.name.parameterize)
  end

  it "renders description in markdown" do
    expect(subject.description).to include('<p>')
  end
end
