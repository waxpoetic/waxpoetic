class Track < ActiveRecord::Base
  # This is the price we sell tracks at by default.
  DEFAULT_PRICE = 1.99

  belongs_to :release

  has_one :artist, :through => :release

  before_validation :ensure_price

  validates :name, presence: true
  validates :artist, presence: true
  validates :release, presence: true
  validates :price, presence: true

  mount_uploader :file, MusicUploader

  private
  def ensure_price
    self.price ||= DEFAULT_PRICE
  end
end

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
#
# Indexes
#
#  index_tracks_on_release_id  (release_id)
#
