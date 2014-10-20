class PodcastSerializer < ActiveModel::Serializer
  attributes :id, :name, :file, :description, :episode_number
end
