class Subscriber < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, email: true
end

# == Schema Information
#
# Table name: subscribers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#
