# Represents a single Artist's photo, usually from a press shoot or live
# performance.
class Photo < ActiveRecord::Base
  belongs_to :artist
  mount_uploader :file, ArtistPhotoUploader

  scope :latest, -> { order :created_at }

  # Fully-qualified URL to the full-size photo.
  def url
    file.url
  end

  # Fully-qualified URL to this photo's thumbnail
  def thumbnail_url
    file.thumb.url
  end
end

# == Schema Information
#
# Table name: photos
#
#  id         :integer          not null, primary key
#  caption    :string(255)
#  file       :string(255)
#  artist_id  :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_photos_on_artist_id  (artist_id)
#
