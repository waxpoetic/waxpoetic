require 'active_model/model'
require 'globalid'

class Subscriber
  include ActiveModel::Model
  include GlobalID::Identification

  attr_accessor :name, :email

  validates :email, presence: true, email: true

  def self.create(params = {})
    subscriber = new params
    subscriber.save
    subscriber
  end

  def self.find(by_id)
    new(email: by_id)
  end

  alias_method :id, :email

  def save
    valid? && subscribe
  end

  def subscribe!
    list.subscribe(
      id: list.id,
      email: { email: email },
      double_optin: false,
      merge_options: {
        'NAME' => name
      }
    )
  end

  def persisted?
    list.members.any? do |member|
      member[:email] == email
    end
  end

  private

  def subscribe
    SubscribeJob.perform_later self
  end

  def list
    @list ||= List.new id: 1
  end
end
