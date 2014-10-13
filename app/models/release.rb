# Release catalog of the record label, sorted by artist.

class Release < ActiveRecord::Base
  belongs_to :artist
  belongs_to :product, class_name: 'Spree::Product'

  PRODUCT_METADATA = %w(catalog_number released_on)

  has_many :tracks, :order => 'number DESC'

  before_validation :calculate_price_from_tracks

  validates :name, presence: true
  validates :released_on, presence: true
  validates :description, presence: true
  validates :catalog_number, presence: true
  validates :price, presence: true
  validates :artist, presence: true

  after_commit :sell!, :on => :create
  after_commit :package!, :on => :create
  after_commit :promote!, :on => :create, :if => :released_today?

  mount_uploader :cover, ImageUploader
  mount_uploader :package, PackageUploader

  delegate :variants, :to => :product

  # "Orphan" releases which have no corresponding Spree::Product record.
  scope :without_product, -> { where product_id: nil }

  # Create the Spree::Product for this Release and begin selling it on
  # the online store. Note that this will *actually* begin selling
  # whenever the `available_on` date is met, which is set to the
  # `released_on` method of this Release record.
  def sell!
    CreateReleaseProduct.enqueue self
  end

  # Generate and upload ZIP packages to the CDN that contain this
  # Release and its Tracks.
  def package!
    PackageRelease.enqueue self
  end

  # Send promotional emails for this Release, upload its Tracks to
  # Soundcloud, and spam various social networks with the link.
  def promote!
    PromoteRelease.enqueue self
  end

  # Attributes given to the Spree::Product when created.
  def product_attributes
    {
      name: decorate.title,
      description: decorate.full_description,
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


  def released_today?
    released_on.to_date == Date.today
  end

  private
  def calculate_price_from_tracks
    self.price ||= tracks.sum(:price)
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
