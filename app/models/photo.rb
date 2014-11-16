# Represents a single Artist's photo, usually from a press shoot or live
# performance.
class Photo < ActiveRecord::Base
  belongs_to :artist
  mount_uploader :file, ArtistPhotoUploader

  scope :latest, -> { |num| order(:created_at).limit(num) }

  # Fully-qualified URL to the full-size photo.
  def url
    file.url
  end

  # Fully-qualified URL to this photo's thumbnail
  def thumbnail_url
    file.thumb.url
  end
end
