# == Schema Information
#
# Table name: artists
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  bio        :text
#  image      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  slug       :string(255)
#

class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :name, :bio, :image
end
