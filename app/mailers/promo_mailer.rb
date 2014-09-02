# Sends emails to people on the promo list
class PromoMailer < ActionMailer::Base
  default from: "promo@waxpoeticrecords.com"

  def new_release(release)
    @release = release.decorate

    Subscriber.all.decorate.each do |subscriber|
      mail \
        to: subscriber.address
        subject: "'#{release.title}' just dropped on Wax Poetic!"
    end
  end
end
