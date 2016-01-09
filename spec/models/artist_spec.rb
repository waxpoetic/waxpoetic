# == Schema Information
#
# Table name: artists
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  bio        :text
#  image      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  slug       :string(255)
#

require 'rails_helper'

RSpec.describe Artist, type: :model do
  subject do
    Artist.new \
      name: 'The Wonder Bars',
      bio: 'A house band from Philadelphia',
      image: files('image.png')
  end

  it 'represents a signed artist on the label' do
    expect(subject).to be_valid
  end

  test_validations_for %w(name bio)
end
