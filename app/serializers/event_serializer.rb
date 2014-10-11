class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :location, :ticket_price, :description
end
