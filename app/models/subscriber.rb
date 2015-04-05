# A form object for the subscribe form as well as a presenter to
# UserSubscribeJob for storing in MailChimp's list.
class Subscriber
  include ActiveModel::Model

  attr_accessor :name, :email

  validates :name, presence: true
  validates :email, presence: true, email: true

  alias_method :id, :email

  def self.create(params = {})
    subscriber = new(params)
    subscriber.save
    subscriber
  end

  def save
    valid? && subscribe
  end

  private

  def subscribe
    UserSubscribeJob.perform_later(self)
  end
end
