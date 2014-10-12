# Sync assets to Amazon S3 and invalidate existing assets on the CDN
# when we deploy.
AssetSync.configure do |config|
  config.fog_provider = 'AWS'
  config.aws_access_key_id = WaxPoetic.config.aws_key
  config.aws_secret_access_key = WaxPoetic.config.aws_secret
  config.fog_directory = "#{WaxPoetic.config.s3_bucket}/assets"

  # Invalidate assets on the CDN after uploading
  config.cdn_distribution_id = Rails.application.secrets.cloudfront_id
  config.invalidate = ['application.js', 'application.css']

  # Automatically replace files with their equivalent gzip compressed version
  config.gzip_compression = true

  # Use the Rails generated 'manifest.yml' file to produce the list of files to
  # upload instead of searching the assets directory.
  config.manifest = true
end if WaxPoetic.live?
