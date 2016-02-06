class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :location, :starts_at, :facebook_id, :url
  has_one :artist
end
