class ArtistsController < ApplicationController
  respond_to :html

  before_action :authenticate_user!, except: %w(index show)

  expose :artists, :only => %w(index) do
    Artist.where search_params
  end
  expose :artist, :attributes => :edit_params, :except => %w(index)

  def index
    respond_with artists.decorate
  end

  def show
    respond_with artist.decorate
  end

  def new
    render :new
  end

  def edit
    render :edit
  end

  def create
    if artist.save
      respond_with artist.decorate
    else
      redirect_to new_artist_path
    end
  end

  def update
    if artist.update_attributes(edit_params)
      respond_with artist.decorate
    else
      redirect_to edit_artist_path(artist)
    end
  end

  def destroy
    artist.destroy
    redirect_to artists_path
  end

  private
  def search_params
    params.permit :name
  end

  def edit_params
    params.require(:artist).permit :name, :bio, :avatar
  end
end
