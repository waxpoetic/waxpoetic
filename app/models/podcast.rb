# A single episode of the podcast.
class Podcast < ActiveRecord::Base
  before_validation :assign_number, :on => :create

  validates :name, presence: true
  validates :description, presence: true
  validates :number, presence: true, uniqueness: true

  mount_uploader :enclosure, MusicUploader

  scope :by_number, -> { order :number }

  private
  def assign_number
    self.number ||= Podcast.count + 1
  end
end

# == Schema Information
#
# Table name: podcasts
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  enclosure   :string(255)
#  description :text
#  number      :integer
#  created_at  :datetime
#  updated_at  :datetime
#
