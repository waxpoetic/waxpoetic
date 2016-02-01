# A blog post written in Trix on the admin interface.
class Article < ActiveRecord::Base
  extend FriendlyId

  validates :title, presence: true
  validates :body, presence: true

  friendly_id :title

  scope :latest, -> { order :created_at }

  alias_method :to_s, :title
end
