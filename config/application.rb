$LOAD_PATH << File.expand_path('../../lib', __FILE__)

require File.expand_path('../boot', __FILE__)

require "rails/all"
require "wax_poetic"

# Require the gems listed in Gemfile
Bundler.require :default, Rails.env

module WaxPoetic
  class Application < Rails::Application
    # Initialize Spree
    config.to_prepare do
      # Load application's model / class decorators
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end

      # Load application's view overrides
      Dir.glob(File.join(File.dirname(__FILE__), "../app/overrides/*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    # Use EST as our local time zone. (UTC is default).
    config.time_zone = 'Eastern Time (US & Canada)'

    # Tables to seed from fixtures when running `db:seed`.
    config.wax_poetic.seed_tables = %w(
      artists releases spree_shipping_categories spree_taxonomies
      spree_taxons spree_option_types spree_option_values
      spree_payment_methods spree_trackers
    )

    # Use localhost as mail server (for Devise)
    config.action_mailer.default_url_options = { host: 'localhost:3000' }

    # The backend queueing system ActiveJob uses, configured in the
    # active_job initializer.
    config.active_job.queue_adapter = :sidekiq

    # Use S3 on staging and production.
    config.wax_poetic.live = Rails.env =~ /production|staging/
    config.wax_poetic.s3_bucket = 'files.waxpoeticrecords.com'

    # By default, just use the cookie to store sessions
    config.session_key = '_wax_poetic_sessions'
    config.session_store :cookie_store, key: config.session_key

    # Configure where we send promotions.
    config.wax_poetic.promote_to = []

    # Read Redis URL from env config
    config.redis_url = ENV['REDIS_URL'] || 'redis://localhost:6379'
  end
end
