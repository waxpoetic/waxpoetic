# Represents an event that Wax Poetic is putting on. Stores the name,
# location, ticket price and date the event occurs on.
class Event < ActiveRecord::Base
  extend FriendlyId
  include Authority::Abilities
  include Saleable

  validates :name, presence: true
  validates :location, presence: true
  validates :ticket_price, presence: true
  validates :starts_at, presence: true

  alias_attribute :price, :ticket_price

  geocoded_by :location
  after_validation :geocode

  friendly_id :name

  def has_product?
    super unless is_saleable?
  end
end

# == Schema Information
#
# Table name: events
#
#  id           :integer          not null, primary key
#  name         :string
#  description  :text
#  ticket_price :string
#  location     :string
#  latitude     :float
#  longitude    :float
#  starts_at    :datetime
#  ends_at      :datetime
#  created_at   :datetime
#  updated_at   :datetime
#  slug         :string
#  is_saleable  :boolean          default(TRUE)
#
# Indexes
#
#  index_events_on_latitude   (latitude)
#  index_events_on_longitude  (longitude)
#
