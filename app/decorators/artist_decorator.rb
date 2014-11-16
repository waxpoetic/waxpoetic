# View-level decorations for Artist objects
class ArtistDecorator < Draper::Decorator
  delegate_all

  # Bio in Markdown.
  def bio
    h.markdown model.bio
  end

  def photo
    h.image_tag model.image.title.url, alt: model.name
  end

  def thumbnail
    h.image_tag model.image.title.url, alt: model.name, class: 'thumbnail'
  end

  def latest_photos
    model.photos.latest.limit(5).map(&:decorate)
  end

  def latest_releases
    model.releases.latest.limit(5).map(&:decorate)
  end
end
