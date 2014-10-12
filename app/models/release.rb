# Release catalog of the record label, sorted by artist.

class Release < ActiveRecord::Base
  belongs_to :artist
  belongs_to :product, class_name: 'Spree::Product'

  has_many :tracks

  before_validation :calculate_price_from_tracks

  validates :name, presence: true
  validates :released_on, presence: true
  validates :description, presence: true
  validates :catalog_number, presence: true
  validates :price, presence: true
  validates :artist, presence: true

  after_commit :create_product_and_variants, :on => :create
  after_commit :create_package, :on => :create
  after_commit :send_promotional_emails, :on => :create

  mount_uploader :cover, ImageUploader
  mount_uploader :package, PackageUploader

  delegate :variants, :to => :product

  # Attributes given to the Spree::Product when created.
  def product_attributes
    {
      name: self.decorate.title,
      description: description,
      available_on: released_on,
      meta_description: description,
      price: price,
      shipping_category: shipping_category
    }
  end

  # The Spree::Image comprised of our cover photo.
  def cover_image
    Spree::Image.new \
      attachment: cover.file,
      alt: self.decorate.title,
      viewable: self
  end

  # Spree's shipping category, used to define a Spree::Product.
  # Required, and we always set it to "Default".
  def shipping_category
    @shipcat ||= Spree::ShippingCategory.find_by_name 'Default'
  end

  private
  def calculate_price_from_tracks
    self.price ||= tracks.sum(:price)
  end

  def create_product_and_variants
    CreateReleaseProduct.enqueue self
  end

  def create_package
    PackageRelease.enqueue self
  end

  def send_promotional_emails
    PromoteRelease.enqueue self if released_on == Date.today
  end
end

# == Schema Information
#
# Table name: releases
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  artist_id      :integer
#  released_on    :datetime
#  cover          :string(255)
#  description    :text
#  catalog_number :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  price          :decimal(19, 2)
#  package        :string(255)
#  product_id     :integer
#
# Indexes
#
#  index_releases_on_artist_id   (artist_id)
#  index_releases_on_product_id  (product_id)
#
