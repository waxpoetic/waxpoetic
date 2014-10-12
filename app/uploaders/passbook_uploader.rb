# encoding: utf-8

class PassbookUploader < CarrierWave::Uploader::Base
  # Store pkpass files in unique directories.
  def store_dir
    "uploads/tickets/#{model.number}"
  end

  # Only allow pkpass files to be uploaded.
  def extension_white_list
    %w(pkpass)
  end
end
