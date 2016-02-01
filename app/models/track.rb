# A single track on a given +Release+.
class Track < ActiveRecord::Base
  extend FriendlyId

  belongs_to :release

  has_one :artist, through: :release

  before_validation :ensure_number

  validates :name,    presence: true
  validates :release, presence: true
  validates :number,  presence: true, numericality: { greater_than: 0 }

  attachment :audio, content_type: ['audio/mp3', 'audio/wav']

  friendly_id :number

  delegate :image, to: :release

  scope :by_number, -> { order :number }

  after_create :shorten!
  after_create :upload!

  # Full title of this song.
  #
  # @return [String]
  def title
    "#{artist.name} - #{name} [#{release.catalog_number}]"
  end

  private

  def ensure_number
    self.number ||= last_track_number + 1
  end

  def last_track_number
    return 0 unless release.present?
    release.tracks.by_number.try(:number).to_i
  end
end

# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  release_id :integer
#  created_at :datetime
#  updated_at :datetime
#  file       :string(255)
#  number     :integer
#  short_url  :string(255)
#
# Indexes
#
#  index_tracks_on_release_id  (release_id)
#
