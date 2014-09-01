class ReleaseSerializer < ActiveModel::Serializer
  attributes :id, :name, :released_on, :cover, :description, :catalog_number
  has_one :artist
end
