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
    config.seed_tables = %w(artists releases)

    # Use localhost as mail server (for Devise)
    config.action_mailer.default_url_options = { host: 'localhost:3000' }

    # Don't promote anywhere by default.
    config.promote_to = []

    # Store sessions on the client side by default.
    config.session_store :cookie_store, key: '_wax_poetic_sessions'

    # Get ready for the next Rails.
    config.active_record.raise_in_transactional_callbacks = true

    # Use a local domain name by default.
    config.domain = 'waxpoetic.dev'

    config.facebook_url = 'https://facebook.com/WaxPoeticRecords'
    config.twitter_url = 'https://twitter.com/WaxPoeticMusic'
    config.soundcloud_url = 'https://soundcloud.com/WaxPoeticMusic'
    config.instagram_url = 'https://instagram.com/WaxPoeticMusic'
    config.spotify_url = 'https://open.spotify.com/user/WaxPoeticMusic'
    config.shop_url = 'https://shop.waxpoeticrecords.com'
  end
end
