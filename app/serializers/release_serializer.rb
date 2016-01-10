# == Schema Information
#
# Table name: releases
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  artist_id      :integer
#  released_on    :datetime
#  image          :string(255)
#  description    :text
#  catalog_number :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  slug           :string(255)
#
# Indexes
#
#  index_releases_on_artist_id  (artist_id)
#

class ReleaseSerializer < ActiveModel::Serializer
  attributes :id, :name, :released_on, :image, :description, :catalog_number
  has_one :artist
end
