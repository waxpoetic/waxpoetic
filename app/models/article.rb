# A blog post written in Trix on the admin interface.
class Article < ActiveRecord::Base
  extend FriendlyId

  validates :title, presence: true
  validates :body, presence: true

  friendly_id :title

  default_scope   -> { order :created_at }
  scope :podcast, -> { where.not audio: nil }
  scope :latest,  -> { limit 5 }

  alias_method :to_s, :title
end
