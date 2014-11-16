# Photo gallery component of artist pages. Artists may upload photos and
# viewers can see them when looking at the artist page.
class PhotosController < ApplicationController
  authenticated_resource :photo do
    protect :index
    ancestor :artist
    modify :caption, :file
  end

  # View all photos by this artist.
  def index
    render photos
  end

  # Upload a new photo.
  def new
    render :new
  end

  # Edit an existing photo.
  def edit
    render :edit
  end

  def create
    photo.save
    respond_with photo
  end

  def update
    photo.update_attributes edit_params
    respond_with photo
  end

  def destroy
    photo.destroy
    respond_with photo
  end
end
