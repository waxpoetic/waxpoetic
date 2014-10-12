class Track < ActiveRecord::Base
  # This is the price we sell tracks at by default.
  DEFAULT_PRICE = 1.99

  belongs_to :release

  has_one :artist, :through => :release

  before_validation :ensure_price, :ensure_number

  validates :name, presence: true
  validates :artist, presence: true
  validates :release, presence: true
  validates :price, presence: true
  validates :number, presence: true

  mount_uploader :file, MusicUploader

  scope :by_track_number, -> { order :number }

  # Attributes given to the Soundcloud API when uploading tracks.
  def soundcloud_attributes
    {
      title: "#{artist.name} - #{name} [#{release.catalog_number}]",
      asset_data: File.new(file.file),
      download: false
    }
  end

  private
  def ensure_price
    self.price ||= DEFAULT_PRICE
  end

  def ensure_number
    self.number ||= last_track_number + 1
  end

  def last_track_number
    return 0 unless release.present?
    release.tracks.by_track_number.try(:number).to_i
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
#
# Indexes
#
#  index_tracks_on_release_id  (release_id)
#
