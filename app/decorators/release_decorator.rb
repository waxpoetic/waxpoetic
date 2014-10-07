# View-level decorations for Release objects.
class ReleaseDecorator < Draper::Decorator
  delegate_all

  # Always display this release as #{ARTIST} - #{NAME}.
  def title
    "#{artist.name} - #{name}"
  end

  # Ensure the filename won't have any spaces or special chars.
  def filename
    "#{name}".parameterize
  end

  # Render the description as entered in by the user to Markdown.
  def description
    h.markdown model.description
  end

  def date
    model.released_on.strftime '%B %e, %Y'
  end

  def photo
    h.image_tag model.cover.url, alt: 'Cover Art'
  end

  def thumbnail
    h.image_tag model.cover.thumbnail.url, alt: title
  end
end
