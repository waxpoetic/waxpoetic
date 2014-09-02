require 'define_product_from_release'

# Release catalog of the record label, sorted by artist.

class Release < ActiveRecord::Base
  belongs_to :artist
  belongs_to :product

  has_many :tracks

  before_validation :calculate_price_from_tracks

  validates :name, presence: true
  validates :released_on, presence: true
  validates :description, presence: true
  validates :catalog_number, presence: true
  validates :price, presence: true
  validates :artist, presence: true

  after_create :define_product,
               :package_into_zip

  mount_uploader :cover, ImageUploader
  mount_uploader :package, PackageUploader

  # Calculated permalink which also forms a kind-of unique ID for now.
  def permalink
    [
      artist.name.parameterize,
      name.parameterize
    ].join '-'
  end

  delegate :variants, :to => :product

  def spree_params
    {
      name: "#{artist.name} - #{name}",
      description: description,
      permalink: permalink,
      available_on: released_on,
      meta_description: description
    }
  end

  private
  def calculate_price_from_tracks
    self.price ||= tracks.sum(:price)
  end

  def define_product
    DefineProductFromRelease.perform self
  end

  def package_into_zip
    PackageRelease.enqueue self
  end
end
