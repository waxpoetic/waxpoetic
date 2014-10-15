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

  it "filters html tags from description" do
    expect(subject.text_description).to_not include('<p>')
  end

  it "combines description and track list" do
    expect(subject.full_description).to eq(
      subject.description + "<h3>Track List</h3>\n".html_safe + subject.track_list
    )
  end

  it "formats release date" do
    expect(subject.date).to eq(release.released_on.strftime('%B %e, %Y'))
  end

  it "builds img tag for full-size cover photo" do
    expect(subject.photo).to match(/\A<img/)
    expect(subject.photo).to match(/alt="Cover Art"/)
  end

  it "builds img tag for cover thumbnail" do
    expect(subject.thumbnail).to match(/\A<img/)
    expect(subject.thumbnail).to match(/alt="#{subject.title}"/)
  end

  it "links to the artist" do
    expect(subject.artist_link).to match(%r(\A<a href="/artists/#{subject.artist.id}"))
  end

  it "renders markdown-driven track listing as text" do
    expect(subject.track_list).to_not be_empty
    expect(subject.track_list).to include('<ol>')
    expect(subject.track_list).to include("<li>The Wonder Bars - After Hours</li>")
  end
end
