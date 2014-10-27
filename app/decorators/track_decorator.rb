# Present Track objects for the view.
class TrackDecorator < Draper::Decorator
  delegate_all

  # The displayable track name in the UI.
  def title
    "#{artist.name} - #{name}"
  end

  # The title prepended with its number on the release.
  def numbered_title
    "#{track.number}. #{track.decorate.title}\n"
  end

  # Generate a slug we will use as this track's short URL.
  def slug
    [artist.name, name].join.parameterize
  end

  # Show a URL to this Track, either the preferred short URL generated
  # by Bitly or the direct CDN URL.
  def url
    model.short_url || model.file.url || 'http://test.host/no-url.wav'
  end

  def release_image
    model.release.decorate.image_file
  end

  def release_date
    model.release.decorate.released_on
  end
end
