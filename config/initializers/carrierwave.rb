# Store stuff on Fog in production.
CarrierWave.configure do |config|
  config.storage = Rails.application.config.file_store
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: Rails.secrets.aws[:secret_key_id],
    aws_access_key_id: Rails.secrets.aws[:secret_access_key],
  }
  config.fog_directory  = 'files.waxpoeticrecords.com'
  config.fog_public     = false
end

# Always store the file in the same kind of dir.
CarrierWave::Uploader::Base.class_eval do
  # Store files according to their model class.
  def store_dir
    "#{model.class.to_s.underscore}/#{model.id}/#{mounted_as.tableize}"
  end
end
