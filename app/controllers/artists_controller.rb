class ArtistsController < ApplicationController
  resource :artist

  # Show all artists in a gallery format
  def index
    respond_with artists
  end

  # Show a single artist's page, which includes upcoming events and
  # photos.
  def show
    respond_with artist
  end
end
