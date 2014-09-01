class Release < ActiveRecord::Base
  belongs_to :artist

  validates :name, presence: true
  validates :released_on, presence: true
  validates :description, presence: true
  validates :catalog_number, presence: true

  mount_uploader :cover, ImageUploader
end
