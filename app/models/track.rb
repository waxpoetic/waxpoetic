class Track < ActiveRecord::Base
  belongs_to :release

  has_one :artist, through: :release

  before_validation :ensure_number

  validates :name, presence: true
  validates :artist, presence: true
  validates :release, presence: true
  validates :number, presence: true

  delegate :image, to: :release

  scope :by_number, -> { order :number }

  after_create :generate_short_url

  # Attributes given to the Soundcloud API when uploading tracks.
  def soundcloud_attributes
    {
      title: "#{artist.name} - #{name} [#{release.catalog_number}]",
      asset_data: nil, # TODO
      download: false,
      private: true
    }
  end

  private

  def ensure_number
    self.number ||= last_track_number + 1
  end

  def last_track_number
    return 0 unless release.present?
    release.tracks.by_number.try(:number).to_i
  end

  def generate_short_url
    GenerateTrackLinkJob.perform_later self
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
#  number     :integer
#  short_url  :string(255)
#  product_id :integer
#
# Indexes
#
#  index_tracks_on_product_id  (product_id)
#  index_tracks_on_release_id  (release_id)
#
