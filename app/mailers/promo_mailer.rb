# A mailer for notifying people on the Subscriber list. Subscribers are
# people who were willingly added to Wax Poetic's DJ promotion list, and
# are typically DJs who get free copies of everything Wax Poetic puts
# out.
class PromoMailer < ActionMailer::Base
  FROM_EMAIL = "promo@waxpoeticrecords.com"
  default from: FROM_EMAIL

  # Send an email when a new release is uploaded.
  def new_release(subscriber, release)
    @release = release.decorate
    @artist = release.artist
    @subscriber = subscriber.decorate
    @subject_line = "'#{@release.title}' just dropped on Wax Poetic!"

    mail to: @subscriber.address, subject: @subject_line
  end
end
