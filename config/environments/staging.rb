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

  # Use Redis to store the "HTTP-level" Rack::Cache
  config.action_dispatch.rack_cache = :redis_store, {
    entitystore: "#{config.redis_url}/0/wax_poetic_rack_entities",
    metastore: "#{config.redis_url}/0/wax_poetic_rack_metadata",
  }

  # Store the Rails.cache in Redis
  config.cache_store = :redis_store, \
    "#{config.redis_url}/1/wax_poetic_rails_cache",
    expires_in: 90.minutes

  # Store the session in Redis
  config.session_store :redis_store, key: config.session_key, redis: {
    db: 2,
    namespace: 'wax_poetic:session:'
  }

  # Disable Rails's static asset server (Apache or nginx will already do this).
  config.serve_static_assets = false

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

  # Simplifed asset host URL so we can use it as a fog directory as well
  config.bucket = 'files.waxpoeticrecords.com/staging'

  # Serve assets from a CDN
  config.action_controller.asset_host = "//#{config.bucket}/assets"

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Disable automatic flushing of the log to improve performance.
  config.autoflush_log = false

  # Set to :debug to see everything in the log.
  config.log_level = :info

  # Use a different logger for distributed setups.
  config.logger = ActiveSupport::TaggedLogging.new Logger.new(STDOUT)

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false
end
