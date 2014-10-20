class ReleaseSerializer < ActiveModel::Serializer
  attributes :id, :name, :released_on, :image, :description, :catalog_number
  has_one :artist
end
