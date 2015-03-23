module Legacy
  class Artist < ActiveRecord::Base
    include LegacyExport

    export :name
    export :description, :full_description

    def full_description
      [description, members].join("\n\n")
    end
  end
end

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
