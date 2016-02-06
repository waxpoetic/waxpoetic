# A blog post written in Trix on the admin interface.
class Article < ActiveRecord::Base
  extend FriendlyId

  validates :title, presence: true
  validates :body, presence: true

  friendly_id :title

  scope :by_date, -> { order :created_at }
  scope :podcast, -> { by_date.where.not audio: nil }
  scope :latest,  -> { by_date.limit 5 }

  alias_method :to_s, :title
end
