# View-level decorations for Release objects.
class ReleaseDecorator < Draper::Decorator
  include MarkdownHelper

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
    markdown model.description
  end

  # Filter out HTML tags from the description for text-based email
  # clients.
  def text_description
    h.strip_tags description
  end

  # The entire product description.
  def full_description
    return description unless model.tracks.any?
    description + "<h3>Track List</h3>\n".html_safe + track_list
  end

  # Formatted release date.
  def date
    model.released_on.strftime '%B %e, %Y'
  end
  alias release_date date

  # <img> tag for the full size image photo.
  def photo
    h.image_tag model.image.url, alt: 'Cover Art'
  end

  # <img> tag for the thumbnailed image photo.
  def thumbnail
    h.image_tag model.image.thumb.url, alt: title
  end

  # Link to this release's artist.
  def artist_link
    h.link_to model.artist.name, model.artist
  end

  # All tracks, in order, output as HTML.
  def track_list
    markdown tracks_as_text
  end

  def image_filepath
    return unless model.image.present?
    File.new model.image_filepath
  end

  def product_path
    "/store/products/#{model.product.name.parameterize}"
  end

  def buy_button
    return unless model.product.present?
    h.link_to "Buy Release (#{price})", product_path, class: 'small buy button success'
  end

  def page_title
    "#{model.name} by #{artist_link}".html_safe
  end

  private
  def tracks_as_text
    model.tracks.by_number.map(&:decorate).reduce '' do |list, track|
      list << %(#{track.numbered_title}\n)
    end
  end
end
