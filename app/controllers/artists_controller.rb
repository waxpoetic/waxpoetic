class ArtistsController < ApplicationController
  authenticated_resource :artist do
    search :name
    modify :name, :bio, :image
  end

  def index
    respond_with artists
  end

  def show
    respond_with artist
  end

  def new
    render :new
  end

  def edit
    render :edit
  end

  def create
    artist.save
    respond_with artist
  end

  def update
    artist.update_attributes(edit_params)
    respond_with artist
  end

  def destroy
    artist.destroy
    redirect_to artists_path
  end
end
