class Subscriber < ActiveRecord::Base
  include ActiveModel::Jobs

  validates :name,  presence: true
  validates :email, presence: true, email: true

  after_create :add!
end
