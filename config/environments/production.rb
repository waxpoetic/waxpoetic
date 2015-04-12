Rails.application.configure do
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

  # Read Redis URL from env config
  config.redis_url = ENV['REDIS_URL'] || 'redis://localhost:6379'

  # Use Redis to store the "HTTP-level" Rack::Cache.
  config.action_dispatch.rack_cache = {
    metastore: "#{config.redis_url}/0/waxpoetic_rack_metadata",
    entitystore: "#{config.redis_url}/0/waxpoetic_rack_entities"
  }

  # Store the Rails.cache in Redis
  config.cache_store = :redis_store, "#{config.redis_url}/0/waxpoetic_rails_cache"

  # Store the session in Redis
  config.session_store = :redis_store, "#{config.redis_url}/0/waxpoetic_rails_session"

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
  config.assets.version = '1.0'

  # Use Nginx sendfile header
  config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect'

  # Ensure we're always connected over SSL
  config.force_ssl = true

  # Serve assets from a CDN
  config.action_controller.asset_host = "//#{config.bucket}/assets"

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Disable automatic flushing of the log to improve performance.
  config.autoflush_log = false

  # Log to syslog in production
  config.log_tags = ['rails']

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  # Promote to all social networks and subscribers
  config.wax_poetic.promote_to = [:email, :soundcloud]

  # Use Amazon SES in production to send mails
  config.action_mailer.delivery_method = :amazon_ses

  # Use a global application logger instance.
  config.logger = WaxPoetic.logger
end
