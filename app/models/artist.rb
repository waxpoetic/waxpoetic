class Artist < ActiveRecord::Base
  has_many :releases

  validates :name, presence: true
  validates :bio, presence: true

  mount_uploader :avatar, ImageUploader
end
