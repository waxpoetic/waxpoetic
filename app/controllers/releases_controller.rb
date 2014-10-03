class ReleasesController < ApplicationController
  expose :artist, :finder_parameter => :artist_id, :except => %w(index)

  def index
    @artist = Artist.find params[:id]
    @releases = @artist.releases.where search_params
    respond_with @releases
  end

  def new
    respond_with artist.releases.build
  end

  def create
    @release = artist.releases.build edit_params

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
end
