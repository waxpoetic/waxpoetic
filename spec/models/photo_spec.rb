# == Schema Information
#
# Table name: photos
#
#  id         :integer          not null, primary key
#  caption    :string(255)
#  file       :string(255)
#  artist_id  :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_photos_on_artist_id  (artist_id)
#

require 'rails_helper'

RSpec.describe Photo, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
