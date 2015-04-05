class Subscriber
  include WaxPoetic::Model

  attr_accessor :name, :email

  validates :email, presence: true, email: true

  def id
    email.parameterize
  end

  def save
    valid? && subscribe
  end

  private

  def subscribe
    SubscribeJob.perform_later self
  end
end
