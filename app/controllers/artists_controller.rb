class ArtistsController < ApplicationController
  respond_to :html

  expose :artists, :attributes => :search_params, :only => [:index]
  expose :artist, :attributes => :edit_params, :except => [:index]

  def index
    respond_with artists
  end

  def show
    respond_with artist
  end

  def create
    if artist.save
      respond_with artist, notice: "New artist saved."
    else
      redirect_to new_artist_path, alert: "Artist could not be saved."
    end
  end

  def update
    if artist.save
      respond_with artist, notice: "New artist saved."
    else
      redirect_to edit_artist_path(artist), \
        alert: "Artist could not be saved."
    end
  end

  def destroy
  end

  private
  def search_params
    params.permit :name
  end

  def edit_params
    params.permit :name, :bio, :avatar
  end
end
