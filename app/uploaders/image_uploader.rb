# Uploader for all images.
class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # Only allow images to be uploaded.
  def extension_white_list
    %w(jpg jpeg png gif)
  end

  version :thumb do
    process :resize_to_fit => [350, 350]
  end

  version :title do
    process :resize_to_fit => [960, 300]
  end

  def default_url(*args)
    "http://placehold.it/#{placeholder_size}&text=#{placeholder_text}"
  end

  private

  def placeholder_size
    case version_name
    when :thumb
      '350x350'
    when :title
      '960x300'
    else
      '960x960'
    end
  end

  def placeholder_text
    model.name.gsub(/\s/, "%20")
  end
end
