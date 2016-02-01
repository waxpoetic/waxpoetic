# View-level decorations for Release objects.
class ReleaseDecorator < ApplicationDecorator
  # Always display this release as #{ARTIST} - #{NAME}.
  def title
    "#{artist.name} - #{name}"
  end

  # Formatted release date.
  def date
    model.released_on.strftime '%B %e, %Y'
  end

  # Link to this release's artist.
  def artist_link
    h.link_to model.artist.name, model.artist
  end
end
