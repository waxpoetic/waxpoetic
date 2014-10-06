Spree.config do |config|
  # Configure the store to look just the same as the frontend.
  config.layout = 'application'
  config.logo = 'logo.jpg'
end

# Use the same User model as the admin panel
Spree.user_class = 'User'

Rails.application.config.to_prepare do
  require_dependency 'spree/authentication_helpers'
end
