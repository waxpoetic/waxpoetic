# When a user signs up, subscribe them to the email list.
class UserSubscribeJob < ActiveJob::Base
  queue_as :default

  def perform(subscriber)
    return unless WaxPoetic.live?
    mailchimp.lists.subscribe list_id: list, email: subscriber.email
  end

  private

  def mailchimp
    @mailchimp ||= Gibbon::API.new WaxPoetic.secrets.mailchimp_api_key
  end
end
