class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :name, :bio, :avatar
end
