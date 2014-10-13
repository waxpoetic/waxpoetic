class TrackDecorator < Draper::Decorator
  delegate_all

  # The displayable track name in the UI.
  def title
    "#{artist.name} - #{name}"
  end

  # Generate a slug we will use as this track's short URL.
  def slug
    [artist.name, name].join('-$').parameterize
  end
end
