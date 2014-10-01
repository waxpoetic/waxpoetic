class PromoteRelease < ActiveJob::Base
  def perform(release)
    Rails.logger.warn "There were no emails sent" if Subscriber.all.empty?

    Subscriber.all.each do |subscriber|
      PromoMailer.new_release(subscriber, release).deliver
    end
  end
end
