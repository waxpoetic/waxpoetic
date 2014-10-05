class ReleasesController < ApplicationController
  respond_to :html

  expose :artist, :finder_parameter => :artist_id
  expose :releases, :ancestor => :artist, :attributes => :search_params, :only => %w(index)
  expose :release, :ancestor => :artist, :attributes => :edit_params, :only => %w(show)

  def index
    respond_with releases
  end

  def show
    respond_with release
  end

  def new
    @artist = Artist.find params[:artist_id]
    respond_with @artist.releases.build
  end

  def create
    @artist = Artist.find params[:artist_id]
    @release = @artist.releases.build edit_params

    if @release.save
      respond_with @release, notice: "New release saved."
    else
      redirect_to :new, alert: "Error adding release."
    end
  end

  private
  def search_params
    params.permit :name, :released_on, :catalog_number, :price
  end

  def edit_params
    params.require(:release).permit :name, :artist_id, :released_on, :description, :catalog_number, :cover
  end
end
