# Store stuff on Fog in production.
CarrierWave.configure do |config|
  if WaxPoetic.live?
    config.storage = :fog
    config.enable_processing = true
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: WaxPoetic.config.aws_key,
      aws_secret_access_key: WaxPoetic.config.aws_secret,
    }
    config.fog_directory  = "#{WaxPoetic.config.s3_bucket}"
    config.fog_public     = false
  else
    config.storage = :file
  end
end

module CarrierWave
  module Uploader
    class Base
      # Store files according to their model class.
      def store_dir
        if WaxPoetic.live?
          default_store_dir
        else
          "uploads/#{default_store_dir}"
        end
      end

      private
      def default_store_dir
        "#{model.class.to_s.pluralize.underscore}/#{model.id}/#{mounted_as.to_s.tableize}"
      end
    end
  end
end
