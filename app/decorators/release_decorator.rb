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

  # Formatted release date.
  def date
    model.released_on.strftime '%B %e, %Y'
  end

  # <img> tag for the full size cover photo.
  def photo
    h.image_tag model.cover.url, alt: 'Cover Art'
  end

  # <img> tag for the thumbnailed cover photo.
  def thumbnail
    h.image_tag model.cover.thumb.url, alt: title
  end

  # Link to this release's artist.
  def artist_link
    h.link_to model.artist.name, model.artist
  end

  # The cover image when seeded.
  def seed_cover_file
    File.new "#{Rails.root}/tmp/images/#{model.name.parameterize}.jpg"
  end

  # Show this release date beautifully.
  def released_on
    model.released_on.strftime '%A %B %e, %Y'
  end

  # All tracks, in order, output as HTML.
  def track_list
    h.markdown tracks_as_text
  end

  # The entire product description.
  def full_description
    description + "<h3>Track List</h3>\n".html_safe + track_list
  end

  private
  def tracks_as_text
    model.tracks.reduce '' do |list, track|
      list << "#{track.number}. #{track.decorate.title}\n"
    end
  end
end
