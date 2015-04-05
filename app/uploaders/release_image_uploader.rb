class ReleaseImageUploader < CarrierWave::Uploader::Base
  include Placeholder

  version :thumb do
    process :resize_to_fit => [240, 240]
  end

  version :micro do
    process :resize_to_fit => [75, 75]
  end
end
