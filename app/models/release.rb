# Release catalog of the record label, sorted by artist. Release records
# are used internally to describe our own releases and relay that
# information to the web site, but this data is also used on creation to
# populate the +Spree::Product+ record that is created for us in the
# online store. Changes between the two records after creation are not
# synchronized at this time.
class Release < ActiveRecord::Base
  extend FriendlyId
  include Saleable
  include Authority::Abilities

  belongs_to :artist

  has_many :tracks

  before_validation :calculate_price_from_tracks

  validates :name, presence: true
  validates :released_on, presence: true
  validates :description, presence: true
  validates :catalog_number, presence: true, uniqueness: true
  validates :price, presence: true
  validates :artist, presence: true

  after_commit :package!, :on => :create
  after_commit :promote!, :on => :create, :if => :released_today?

  accepts_nested_attributes_for :tracks

  mount_uploader :image, ReleaseImageUploader
  mount_uploader :open_source_package, PackageUploader
  mount_uploader :file, PackageUploader

  friendly_id :catalog_number

  delegate :variants, :to => :product

  scope :latest, -> { order :released_on }

  # Generate and upload ZIP packages to the CDN that contain this
  # Release and its Tracks.
  def package!
    PackageRelease.enqueue self
  end

  # Send promotional emails for this Release, upload its Tracks to
  # Soundcloud, and spam various social networks with the link. This
  # is run automatically when Release is +released_today?+
  def promote!
    PromoteRelease.enqueue self
  end

  # Spree's shipping category, used to define a Spree::Product.
  # Required, and we always set it to "Default".
  def shipping_category
    @shipcat ||= Spree::ShippingCategory.find_by_name 'Default'
  end

  # Test if the +released_on+ date is equal to today. Used by the
  # promotion engine to verify whether this Release needs to be
  # promoted.
  def released_today?
    released_on.to_date == Date.today
  end

  private

  def calculate_price_from_tracks
    self.price ||= tracks.sum :price
  end
end

# == Schema Information
#
# Table name: releases
#
#  id                  :integer          not null, primary key
#  name                :string(255)
#  artist_id           :integer
#  released_on         :datetime
#  image               :string(255)
#  description         :text
#  catalog_number      :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  price               :decimal(19, 2)
#  file                :string(255)
#  product_id          :integer
#  slug                :string(255)
#  open_source_package :string(255)
#
# Indexes
#
#  index_releases_on_artist_id   (artist_id)
#  index_releases_on_product_id  (product_id)
#
