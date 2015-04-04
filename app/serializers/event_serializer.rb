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
#
# Indexes
#
#  index_events_on_latitude   (latitude)
#  index_events_on_longitude  (longitude)
#

class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :location, :ticket_price, :description
end
