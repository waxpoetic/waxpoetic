class ReleasesController < ApplicationController
  authenticated_resource :release do
    search :name, :released_on, :catalog_number, :price, :artist_id

    modify :name, :artist_id, :released_on, :description,
           :catalog_number, :image, :open_source_package, :tracks
  end

  def index
    respond_with releases
  end

  def show
    respond_with release
  end

  def new
    render :new
  end

  def edit
    render :edit
  end

  def create
    release.save
    respond_with release
  end

  def update
    release.update_attributes(edit_params)
    respond_with release
  end

  def destroy
    release.destroy
    respond_with release
  end
end
