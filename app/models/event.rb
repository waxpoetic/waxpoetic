# Represents an event that Wax Poetic is putting on. Stores the name,
# location, ticket price and date the event occurs on.
class Event < ActiveRecord::Base
  validates :name, presence: true
  validates :location, presence: true
  validates :ticket_price, presence: true
  validates :starts_at, presence: true

  geocoded_by :location
end
