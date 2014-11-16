class PhotoDecorator < Draper::Decorator
  delegate_all

  def thumbnail
    h.lazy_image_tag model.thumbnail_url, alt: photo.caption
  end
end
