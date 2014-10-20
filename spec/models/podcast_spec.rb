# == Schema Information
#
# Table name: podcasts
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  enclosure   :string(255)
#  description :text
#  number      :integer
#  created_at  :datetime
#  updated_at  :datetime
#

require 'rails_helper'

RSpec.describe Podcast, :type => :model do
  subject do
    Podcast.new \
      name: 'episode name',
      description: 'a little more',
      enclosure: File.new('spec/fixtures/files/podcast.wav')
  end

  test_validations_with %w(name description)

  it "uploads a podcast episode" do
    expect(subject).to be_valid
  end

  it "assigns the number" do
    expect(subject).to be_valid
    expect(subject.number).to eq(2)
  end

  it "ensures number is unique" do
    episode = podcasts :one
    subject.number = episode.number
    expect(subject).to_not be_valid
  end
end
