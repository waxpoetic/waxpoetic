class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@#{Rails.configuration.domain}"
  layout 'mailer'
end
