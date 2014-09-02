# For uploading ZIP-packaged releases as well as open-source editions of
# Tracks.
class PackageUploader < CarrierWave::Uploader::Base
  # Always store packages in their release files dir.
  def store_dir
    "releases/#{model.id}/packages"
  end

  # Only allow .ZIP files to be uploaded with this class.
  def extension_white_list
    %w(zip)
  end
end
