# View-level decorations for Artist objects
class ArtistDecorator < ApplicationDecorator
  # Biography written with Trix.
  def bio
    model.bio.html_safe
  end
end
