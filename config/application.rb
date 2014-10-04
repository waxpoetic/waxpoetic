require File.expand_path('../boot', __FILE__)

require "rails/all"

# Require the gems listed in Gemfile
Bundler.require :default, Rails.env

module WaxPoetic
  class Application < Rails::Application
    # Spree stuff.
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

    # Tables to seed when running `db:seed`.
    config.seed_tables = %w(artists releases)

    # Use localhost as mail server (for Devise)
    config.action_mailer.default_url_options = { host: 'localhost:3000' }

    # File storage location for Fog and CarrierWave.
    config.file_store = if Rails.env.production?
      :fog
    else
      :file
    end

    # The backend queueing system ActiveJob uses, configured in the
    # active_job initializer.
    config.queue_adapter = :sidekiq

    # Static data to seed into the DB in all environments.
    config.seed_tables = %w(spree_shipping_categories)
  end
end
