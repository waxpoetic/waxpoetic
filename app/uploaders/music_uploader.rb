# For uploading music to Track or Podcast records.
class MusicUploader < CarrierWave::Uploader::Base
  version :preview do
    process :trim
  end

  # Always store track files in the track dir.
  def store_dir
    "tracks/#{model.id}/files"
  end

  # Only allow high-quality audio files to be uploaded.
  def extension_white_list
    %w(wav)
  end

  private

  def trim
    %x(
      mv #{current_path} #{current_path}.old;
      sox #{current_path}.old #{current_path} trim #{starts_at} #{ends_at};
    )
  end

  def starts_at
    model.preview_starts_at
  end

  def ends_at
    model.preview_ends_at
  end
end
