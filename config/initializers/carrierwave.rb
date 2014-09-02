# Store stuff on Fog in production.
CarrierWave.configure do |config|
  config.storage = :fog
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: Rails.application.secrets.aws[:access_key_id],
    aws_secret_access_key: Rails.application.secrets.aws[:secret_access_key],
  }
  config.fog_directory  = 'files.waxpoeticrecords.com'
  config.fog_public     = false
end if Rails.env.production?

module CarrierWave
  module Uploader
    class Base
      # Store files according to their model class.
      def store_dir
        "#{model.class.to_s.underscore}/#{model.id}/#{mounted_as.tableize}"
      end
    end
  end
end
