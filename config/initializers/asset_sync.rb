# Configure syncing assets to S3 when we deploy.
AssetSync.configure do |config|
  config.fog_provider = 'AWS'
  config.aws_access_key_id = Rails.application.secrets.aws[:access_key_id]
  config.aws_secret_access_key = Rails.application.secrets.aws[:secret_access_key]
  config.fog_directory = 'assets.waxpoeticrecords.com'

  # Invalidate a file on a cdn after uploading files
  config.cdn_distribution_id = Rails.application.secrets.cloudfront_id
  config.invalidate = ['application.js', 'application.css']

  # Don't delete files from the store
  #config.existing_remote_files = "keep"

  # Automatically replace files with their equivalent gzip compressed version
  config.gzip_compression = true

  # Use the Rails generated 'manifest.yml' file to produce the list of files to
  # upload instead of searching the assets directory.
  config.manifest = true
end if Rails.env.production?
