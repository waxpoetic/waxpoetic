class Subscriber < ActiveRecord::Base
  belongs_to :artist

  include ActiveModel::Jobs

  validates :email, presence: true, email: true

  after_create :add!

  delegate :list_id, to: :artist, allow_nil: true
end

# == Schema Information
#
# Table name: subscribers
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
