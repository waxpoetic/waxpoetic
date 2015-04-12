# A form object for the subscribe form as well as a presenter to
# UserSubscribeJob for storing in MailChimp's list.
class Subscriber
  include ActiveModel::Model

  attr_accessor :name, :email

  validates :name, presence: true
  validates :email, presence: true, email: true

  alias_method :id, :email

  class << self
    def create(params = {})
      subscriber = new(params)
      subscriber.save
      subscriber
    end

    def find(email)
      new(email)
    end

    def add!(email: nil, name: nil)
      list.subscribe(
        list_id: list_id,
        email: { email: email },
        options: { 'NAME' => name }
      )
    end

    def count
      list.subscribers.size
    end

    def list
      mailchimp.lists
    end

    private

    def list_id
      WaxPoetic.secrets.mailchimp_list_id
    end

    def mailchimp
      @mailchimp ||= Gibbon::API.new WaxPoetic.secrets.mailchimp_api_key
    end
  end

  def save
    valid? && subscribe
  end

  def persisted?
    self.class.list.subscribers.any? do |subscriber|
      subscriber[:email] == email
    end
  end

  def attributes
    { name: name, email: email }
  end

  private

  def subscribe
    UserSubscribeJob.perform_later(self) unless persisted?
  end
end
