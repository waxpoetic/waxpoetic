# Send promotional emails to every Subscriber.
class EmailPromoter < WaxPoetic::Promoter
  def promote!(release, options={})
    subscribers = options[:to]
    logger.warn "There were no emails sent" if subscribers.empty?

    subscribers.each do |subscriber|
      PromoMailer.new_release(subscriber, release).deliver
    end
  end
end
