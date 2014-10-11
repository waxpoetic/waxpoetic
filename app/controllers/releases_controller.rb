class ReleasesController < ApplicationController
  respond_to :html

  before_action :authenticate_user!, except: %w(index show)

  expose :releases, :attributes => :search_params, :only => %w(index)
  expose :release, :attributes => :edit_params, :except => %w(index)

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
    if release.save
      respond_with release, notice: "New release added."
    else
      redirect_to new_release_path, alert: error_msg(release, "couldn't be added")
    end
  end

  def update
    if release.update_attributes(edit_params)
      respond_with release, notice: "Release saved."
    else
      redirect_to new_release_path, alert: error_msg(release, "couldn't be saved")
    end
  end


  def destroy
    if release.destroy
      respond_with release, notice: "Deleted release."
    else
      respond_with release, alert: error_msg(release, "couldn't be deleted")
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
