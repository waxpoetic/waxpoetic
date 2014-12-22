# = Releases API
#
# Controls the release catalog as well as provides the means to view and
# purchase new releases. While all users can view releases, only admins
# may edit them. Admin buttons appear on each release's show page.
class ReleasesController < ApplicationController
  respond_to :html
  resource :release do
    search :name, :released_on, :catalog_number, :price, :artist_id

    modify :name, :artist_id, :released_on, :description,
           :catalog_number, :image, :open_source_package, :tracks
  end

  # Public: View all releases.
  def index
    respond_with releases
  end

  # Public: View a single release.
  def show
    respond_with release
  end

  # Protected: Render the form ta add a new release.
  def new
    render :new
  end

  # Protected: Render the form to edit an existing release.
  def edit
    render :edit
  end

  # Protected: Save a new release to the database.
  def create
    release.save
    respond_with release
  end

  # Protected: Update an existing release in the database.
  def update
    release.update_attributes(edit_params)
    respond_with release
  end

  # Protected: Remove an existing release from the database.
  def destroy
    release.destroy
    respond_with release
  end
end
