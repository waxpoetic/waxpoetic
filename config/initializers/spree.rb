# Configure Spree Preferences
#
# Note: Initializing preferences available within the Admin will overwrite any changes that were made through the user interface when you restart.
#       If you would like users to be able to update a setting with the Admin it should NOT be set here.
#
# In order to initialize a setting do:
# config.setting_name = 'new value'
Spree.config do |config|
  config.layout = 'application'
  config.logo = 'logo.png'
  config.site_name = 'Wax Poetic Records'
  config.site_url = 'http://www.waxpoeticrecords.com/store'
  config.use_s3 = Rails.configuration.use_s3
  config.s3_bucket = 'files.waxpoeticrecords.com'
  config.s3_access_key = Rails.application.secrets.aws[:access_key_id]
  config.s3_secret = Rails.application.secrets.aws[:secret_access_key]
end

Spree.user_class = 'User'
