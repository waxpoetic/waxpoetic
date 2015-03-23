class Artist < ActiveRecord::Base
  extend FriendlyId
  include Authority::Abilities
  include Exportable

  has_many :releases

  validates :name, presence: true
  validates :bio, presence: true

  mount_uploader :image, ArtistImageUploader

  friendly_id :name

  def to_label
    name
  end
end

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
