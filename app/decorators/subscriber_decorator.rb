class SubscriberDecorator < Draper::Decorator
  # RFC-compliant address featuring user's name.
  def address
    "#{name} <#{email}>"
  end
end
