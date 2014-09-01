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

  private
  def ensure_price
    self.price ||= DEFAULT_PRICE
  end
end
