class SubscriberDecorator < Draper::Decorator
  # RFC-compliant address featuring user's name.
  def address
    "#{model.name} <#{model.email}>"
  end
end
