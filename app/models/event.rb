# Represents an event that Wax Poetic is putting on. Stores the name,
# location, ticket price and date the event occurs on.
class Event < ActiveRecord::Base
  validates :name, presence: true
  validates :location, presence: true
  validates :ticket_price, presence: true
  validates :starts_at, presence: true

  geocoded_by :location
  after_validation :geocode
end

# == Schema Information
#
# Table name: events
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  description  :text
#  ticket_price :string(255)
#  location     :string(255)
#  latitude     :float
#  longitude    :float
#  starts_at    :datetime
#  ends_at      :datetime
#  created_at   :datetime
#  updated_at   :datetime
#
