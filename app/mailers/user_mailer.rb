class UserMailer < ActionMailer::Base
  default from: "events@waxpoeticrecords.com"

  def ticket_available(for_user)
    @user = for_user
    mail to: @user.email, subject: "Your tickets are available"
  end
end
