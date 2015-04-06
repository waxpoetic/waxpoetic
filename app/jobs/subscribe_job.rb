# Subscribe someone to the newsletter.
class SubscribeJob < ActiveJob::Base
  queue_as :default

  def perform(subscriber)
    subscriber.subscribe!
  end
end
