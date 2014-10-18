# Uploader for all images.
class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # Only allow images to be uploaded.
  def extension_white_list
    %w(jpg jpeg png)
  end
end
