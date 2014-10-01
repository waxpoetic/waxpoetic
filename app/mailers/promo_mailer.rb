# Sends emails to people on the promo list
class PromoMailer < ActionMailer::Base
  FROM_EMAIL = "promo@waxpoeticrecords.com"
  default from: FROM_EMAIL

  def new_release(subscriber, release)
    @release = release.decorate
    @subscriber = subscriber.decorate
    @subject_line = "'#{@release.title}' just dropped on Wax Poetic!"

    mail to: @subscriber.address, subject: @subject_line
  end
end
