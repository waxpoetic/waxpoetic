# Sync assets to Amazon S3 and invalidate existing assets on the CDN
# when we deploy.
AssetSync.configure do |config|
  config.fog_provider = 'AWS'
  config.aws_access_key_id = WaxPoetic.secrets.aws['access_key_id']
  config.aws_secret_access_key = WaxPoetic.secrets.aws['secret_access_key']
  config.fog_directory = WaxPoetic.config.s3_bucket

  # Invalidate assets on the CDN after uploading
  config.cdn_distribution_id = WaxPoetic.secrets.cloudfront_id
  config.invalidate = ['application.js', 'application.css']

  # Automatically replace files with their equivalent gzip compressed version
  config.gzip_compression = true

  # Use the Rails generated 'manifest.yml' file to produce the list of files to
  # upload instead of searching the assets directory.
  config.manifest = true
end if defined? AssetSync
