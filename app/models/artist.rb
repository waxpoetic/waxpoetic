class Artist < ActiveRecord::Base
  extend FriendlyId
  include Exportable

  has_many :releases
  has_many :events

  validates :name, presence: true
  validates :bio, presence: true

  friendly_id :name
  alias_method :to_s, :name

  def to_label
    name
  end

  def page
    @page ||= Facebook::Page.find facebook_page_id
  end

  def tracks_event?(event)
    events.where(facebook_id: event.facebook_id).any?
  end
end

# == Schema Information
#
# Table name: artists
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  bio        :text
#  image      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  slug       :string(255)
#
