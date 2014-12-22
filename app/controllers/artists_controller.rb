# # Artists API
#
# This is the artists API, which lives at /artists and is responsible
# for rendering each artist page. While all users can view the show and
# index routes, only admins may edit and create artists, and therefore
# use the rest of the HTTP API. Admin buttons appear on each artist's
# show page.
class ArtistsController < ApplicationController
  resource :artist do
    search :name
    modify :name, :bio, :image
  end

  # Show all artists in a gallery format
  def index
    respond_with artists
  end

  # Show a single artist's page, which includes upcoming events and
  # photos.
  def show
    respond_with artist
  end

  # Protected: Render the form to create a new artist.
  def new
    render :new
  end

  # Protected: Render the form to edit an existing artist.
  def edit
    render :edit
  end

  # Protected: Save a new artist to the database.
  def create
    artist.save
    respond_with artist
  end

  # Protected: Update an existing artist in the database.
  def update
    artist.update_attributes(edit_params)
    respond_with artist
  end

  # Protected: Remove an artist from the database.
  def destroy
    artist.destroy
    redirect_to artists_path
  end
end
