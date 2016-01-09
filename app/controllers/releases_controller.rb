class ReleasesController < ApplicationController
  resource :release

  # Public: View all releases.
  def index
    respond_with releases
  end

  # Public: View a single release.
  def show
    respond_with release
  end
end
