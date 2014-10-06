class ReleasesController < ApplicationController
  respond_to :html

  expose :releases, :attributes => :search_params, :only => %w(index)
  expose :release, :attributes => :edit_params, :except => %w(index create)

  def index
    respond_with releases
  end

  def show
    respond_with release
  end

  def new
    # new form
  end

  def edit
    respond_with release
  end

  def create
    @release = Release.new edit_params
    if @release.save
      respond_with @release, notice: "New release saved."
    else
      redirect_to new_release_path, \
        alert: "Error adding release: #{@release.errors.full_messages.join(', ')}"
    end
  end

  private
  def search_params
    params.permit :name, :released_on, :catalog_number, :price, :artist_id
  end

  def edit_params
    params.require(:release).permit \
      :name, :artist_id, :released_on, :description, :catalog_number, :cover
  end
end
