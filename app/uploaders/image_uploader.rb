# Uploader for all images.
class ImageUploader < CarrierWave::Uploader::Base
  include Placeholder

  version :thumb do
    process :resize_to_fit => [350, 350]
  end

  version :title do
    process :resize_to_fit => [960, 300]
  end
end
