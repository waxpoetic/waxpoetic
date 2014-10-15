class ArtistsController < ApplicationController
  respond_to :html

  before_action :authenticate_user!, except: %w(index show)

  expose :artists, :only => %w(index) do
    Artist.where(search_params).decorate
  end
  expose :artist, :attributes => :edit_params, :except => %w(create index)

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
    @artist = Artist.new edit_params

    if @artist.save
      respond_with @artist
    else
      redirect_to new_artist_path
    end
  end

  def update
    if artist.update_attributes(edit_params)
      respond_with artist, notice: "Artist saved."
    else
      redirect_to edit_artist_path(artist), alert: error_msg(artist)
    end
  end

  def destroy
    if artist.destroy
      redirect_to :artists, notice: "Artist deleted."
    else
      redirect_to :artists, alert: error_msg(artist, 'could not be deleted')
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
