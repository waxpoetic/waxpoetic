module Legacy
  class Release < ActiveRecord::Base
    include LegacyExport

    export :name
    export :released_on
    export :catalog_number
    export :description, :full_description

    def full_description
      [description, notes, "# Track List", tracks].join("\n\n")
    end
  end
end

# == Schema Information
#
# Table name: releases
#
#  id                  :integer          not null, primary key
#  name                :string(255)
#  artist_id           :integer
#  released_on         :datetime
#  image               :string(255)
#  description         :text
#  catalog_number      :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  price               :decimal(19, 2)
#  file                :string(255)
#  product_id          :integer
#  slug                :string(255)
#  open_source_package :string(255)
#
# Indexes
#
#  index_releases_on_artist_id   (artist_id)
#  index_releases_on_product_id  (product_id)
#
