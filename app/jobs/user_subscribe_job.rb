# When a user signs up, subscribe them to the email list.
class UserSubscribeJob < ActiveJob::Base
  queue_as :default

  def perform(subscriber)
    return true unless WaxPoetic.live?
    Subscriber.add! subscriber.attributes
  end
end
