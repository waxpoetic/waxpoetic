class Subscriber < ActiveRecord::Base
  include ActiveModel::Jobs

  validates :email, presence: true, email: true

  after_create :add!
end
