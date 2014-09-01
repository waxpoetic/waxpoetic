class Release < ActiveRecord::Base
  belongs_to :artist

  has_many :tracks

  before_validation :calculate_price_from_tracks

  validates :name, presence: true
  validates :released_on, presence: true
  validates :description, presence: true
  validates :catalog_number, presence: true
  validates :price, presence: true
  validates :artist, presence: true

  mount_uploader :cover, ImageUploader

  private
  def calculate_price_from_tracks
    self.price ||= tracks.sum(:price)
  end
end
