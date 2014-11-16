class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :caption, :file
  has_one :artist
end
