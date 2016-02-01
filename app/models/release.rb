# Release catalog of the record label, sorted by artist. Release records
# are used internally to describe our own releases and relay that
# information to the web site.
class Release < ActiveRecord::Base
  extend FriendlyId

  belongs_to :artist

  has_many :tracks

  validates :name, presence: true
  validates :artist, presence: true
  validates :released_on, presence: true
  validates :description, presence: true
  validates :catalog_number, presence: true, uniqueness: true

  accepts_nested_attributes_for :tracks

  friendly_id :catalog_number
  alias_method :to_s, :name

  delegate :variants, to: :product

  scope :latest, -> { order :released_on }

  after_create :promote!

  # Test if the +released_on+ date is equal to today. Used by the
  # promotion engine to verify whether this Release needs to be
  # promoted.
  def released_today?
    released_on.to_date == Date.today
  end

  private

  # Promote this +Release+ on the release date.
  def promote!
    PromoteReleaseJob.new(self).perform_later wait: released_on
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
#  image          :string(255)
#  description    :text
#  catalog_number :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  slug           :string(255)
#
# Indexes
#
#  index_releases_on_artist_id  (artist_id)
#
