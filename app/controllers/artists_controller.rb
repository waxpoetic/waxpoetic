class ArtistsController < ApplicationController
  respond_to :html

  before_action :authenticate_user!, :except => [:index, :show]

  expose :artists, :attributes => :search_params, :only => [:index]
  expose :artist, :only => [:show]

  def index
    respond_with artists
  end

  def show
    respond_with artist
  end

  def new
    render :new
  end

  def create
    @artist = Artist.new edit_params

    if @artist.save
      respond_with @artist, notice: "New artist saved."
    else
      redirect_to :new, alert: "Artist could not be saved."
    end
  end

  def update
    @artist = Artist.find params[:id]

    if @artist.update_attributes(edit_params)
      respond_with @artist, notice: "New artist saved."
    else
      redirect_to :edit, alert: "Artist could not be saved."
    end
  end

  def destroy
    @artist = Artist.find params[:id]

    if @artist.destroy
      redirect_to :artists, notice: "Artist deleted."
    else
      redirect_to :artists, alert: "Error deleting artist."
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
