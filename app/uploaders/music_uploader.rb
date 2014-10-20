# For uploading music to Track or Podcast records.
class MusicUploader < CarrierWave::Uploader::Base
  process :transcode_to_mp3

  # Always store track files in the track dir.
  def store_dir
    "tracks/#{model.id}/files"
  end

  # Only allow high-quality audio files to be uploaded.
  def extension_white_list
    %w(wav)
  end
end
