class ArtistsController < ApplicationController
  respond_to :html

  before_action :authenticate_user!, :except => [:index, :show]

  expose :artists, :attributes => :search_params, :only => [:index]
  expose :artist, :except => [:index]

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
    if artist.destroy
      redirect_to artists_path, notice: "Artist deleted."
    else
      redirect_to artists_path, alert: "Error deleting artist."
    end
  end

  private
  def search_params
    params.permit :name
  end

  def edit_params
    params.require(:artist).permit :name, :bio, :avatar
  end
end
