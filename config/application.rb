$LOAD_PATH << File.expand_path('../../lib', __FILE__)

require File.expand_path('../boot', __FILE__)
require 'rails'

%w(
  active_record
  action_controller
  action_view
  action_mailer
  active_job
  sprockets
).each do |framework|
  begin
    require "#{framework}/railtie"
  rescue LoadError
  end
end

Bundler.require :default, Rails.env

require 'wax_poetic'

module WaxPoetic
  # The Rails application used to power the Wax Poetic Records online
  # store. This is where we store global configuration which will not
  # change across environments.
  class Application < Rails::Application
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

    # Use S3 on staging and production.
    config.wax_poetic.live = Rails.env =~ /production|staging/
    config.wax_poetic.s3_bucket = 'files.waxpoeticrecords.com'

    # Don't promote anywhere by default.
    config.wax_poetic.promote_to = []

    # Store sessions on the client side by default.
    config.session_key = '_wax_poetic_sessions'
    config.session_store :cookie_store, key: config.session_key

    # Configure generators to use RSpec as a test framework, don't
    # generate separate factory files, and to use SCSS and CoffeeScript
    # when generating resources. Also, this turns off generating helper
    # modules as we frequently use decorators over modules.
    config.generators do |g|
      g.factory_girl false
      g.test_framework :rspec
      g.stylesheet_engine :sass
      g.javascript_engine :coffee
      g.helper false
    end

    # Get ready for the next Rails
    config.active_record.raise_in_transactional_callbacks = true

    # Add library code to autoload paths
    config.autoload_paths << "#{Rails.root}/lib"
    config.eager_load_paths << "#{Rails.root}/lib"
  end
end
