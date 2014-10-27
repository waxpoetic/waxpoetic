# Methods for storing a file resource on disk along with the model.
module Storable
  extend ActiveSupport::Concern

  included do
    mount_uploader :file, MusicUploader
    after_create :start_transcode
  end

  # Find the fully-qualified filepath without the protocol.
  def filepath
    self.file.url.gsub(/\Ahttp:\/\/|https:\/\//, '')
  end
  alias wav_filepath filepath

  # Change the file extension to MP3.
  def mp3_filepath
    filepath.gsub(/\.wav\Z/, '.mp3')
  end

  protected
  def start_transcode
    Transcode.enqueue self
  end
end
