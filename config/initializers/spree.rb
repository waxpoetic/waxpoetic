Spree.config do |config|
  # Configure the store to look just the same as the frontend.
  config.layout = 'application'
  config.logo = 'logo.jpg'
  config.site_name = "Wax Poetic Records"
  config.site_url = "https://www.waxpoeticrecords.com"

  # Brand the admin interface as much as possible
  config.admin_interface_logo = 'logo.jpg'

  # Store Spree uploads with the rest of the uploads.
  config.attachment_path = "/uploads/spree/products/:id/:style/:basename.:extension"

  # Upload attachments to Amazon S3 in production & staging
  if WaxPoetic.live?
    config.use_s3 = true
    config.s3_bucket = WaxPoetic.config.s3_bucket
    config.s3_access_key = WaxPoetic.secrets.aws[:access_key_id]
    config.s3_secret = WaxPoetic.secrets.aws[:secret_access_key]
  end

  # Only force SSL in production.
  config.allow_ssl_in_production = true
  config.allow_ssl_in_staging = false
  config.allow_ssl_in_development_and_test = false
end

# Use the same User model as the admin panel
Spree.user_class = 'User'
Rails.application.config.to_prepare do
  require_dependency 'spree/authentication_helpers'
end
