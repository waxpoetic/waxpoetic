Rails.application.configure do
  # Configure domain to point to staging URL
  config.domain = 'dev.waxpoeticrecords.com'

  # Cache redis URL
  redis_url = WaxPoetic.secrets.redis_url

  # Code is not reloaded between requests.
  config.cache_classes = true

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both threaded web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Use Redis to store the "HTTP-level" Rack::Cache
  config.action_dispatch.rack_cache = {
    metastore: "#{redis_url}/0/rack-metastore",
    entitystore: "#{redis_url}/0/rack-entitystore"
  }

  # Store the Rails.cache in Redis
  config.cache_store = :redis_store, "#{redis_url}/0/cache", {
    expires_in: 90.minutes
  }

  # Store the session in Redis
  config.session_store :redis_store, servers: "#{redis_url}/0/session"

  # Use Redis to persist background jobs
  config.active_job.queue_adapter = :sidekiq

  # Disable Rails's static asset server (Apache or nginx will already do this).
  config.serve_static_files = false

  # Compress JavaScripts and CSS.
  config.assets.js_compressor = :uglifier
  config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = false

  # Generate digests for assets URLs.
  config.assets.digest = true

  # Version of your assets, change this if you want to expire all your assets.
  config.assets.version = WaxPoetic.version.format '%M.%m.%p%s'
  # Serve assets from a CDN
  config.action_controller.asset_host = "files.#{config.domain}"

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Disable automatic flushing of the log to improve performance.
  config.autoflush_log = false

  # Set to :debug to see everything in the log.
  config.log_level = :info

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  config.promote_to = [:email, :soundcloud]

  # Configure SMTP Sendgrid settings
  config.action_mailer.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    address: 'smtp.sendgrid.net',
    port: '587',
    authentication: :plain,
    user_name: WaxPoetic.secrets.sendgrid_username,
    password: WaxPoetic.secrets.sendgrid_password,
    domain: 'waxpoeticrecords.com',
    enable_starttls_auto: true
  }
end
