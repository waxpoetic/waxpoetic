class ArtistImageUploader < ImageUploader
  version :title do
    process :resize_to_fill => [960, 240]
  end

  version :thumb do
    process :resize_to_fill => [736, 155]
  end
end
