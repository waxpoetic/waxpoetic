class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :name, :bio, :image
end
