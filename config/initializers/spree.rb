Spree.config do |config|
  # Configure the store to look just the same as the frontend.
  config.layout = 'application'
  config.logo = 'logo.jpg'

  # Brand the admin interface as much as possible
  config.admin_interface_logo = 'logo.jpg'
=begin
  # Upload attachments to Amazon S3 in production & staging
  if WaxPoetic.live?
    config.use_s3 = true
    config.s3_bucket = WaxPoetic.config.s3_bucket
    config.s3_access_key = WaxPoetic.secrets.aws['access_key_id']
    config.s3_secret = WaxPoetic.secrets.aws['secret_access_key']
  end
=end
  # Only force SSL in production.
  config.allow_ssl_in_production = true
  config.allow_ssl_in_staging = false
  config.allow_ssl_in_development_and_test = false

  # Until we begin selling merchandise, we don't need to track inventory
  # levels in the online store.
  config.track_inventory_levels = false
end

# Use the same User model as the admin panel
Spree.user_class = 'User'
Rails.application.config.to_prepare do
  require_dependency 'spree/authentication_helpers'
end

# Simplify checkout flow to disable delivery and address steps.
Spree::Order.class_eval do
  belongs_to :download
  remove_checkout_step :address
  remove_checkout_step :delivery
  insert_checkout_step :create_download, :before => :confirm
end

# Store a reference to the catalog record this product represents within
# the product table.
Spree::Product.class_eval do
  belongs_to :saleable, polymorphic: true
end

# A hack for decorators so they always have a default shipping category
module Draper
  class Decorator
    def default_shipping_category
      Spree::ShippingCategory.find_by_name 'Default'
    end
  end
end
