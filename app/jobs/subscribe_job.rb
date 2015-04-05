# Subscribe someone to the newsletter.
class SubscribeJob < ActiveJob::Base
  queue_as :default

  def perform(subscriber)
    mailchimp.lists.subscribe(
      id: WaxPoetic.config.mailchimp.news_list_id,
      email: { email: subscriber.email },
      double_optin: false,
      merge_options: {
        'NAME' => subscriber.name
      }
    )
  end

  private

  def mailchimp
    @mailchimp ||= Gibbon::API.new WaxPoetic.secrets.mailchimp_key
  end
end
