# +Release+ catalog API. Releases can etherh
class ReleasesController < ApplicationController
  expose :artist
  resource :release, ancestor: :artist, if: :artist_present?
  resource :release, unless: :artist_present?

  # View all releases, either by a given +Artist+ or the entire catalog.
  #
  # @http [GET] /releases
  # @http [GET] /artists/the-wonder-bars/releases
  def index
    respond_with releases
  end

  # View a single release.
  #
  # @http [GET] /releases/WXP005
  # @http [GET] /artists/research-and-development/releases/WXP005
  def show
    respond_with release
  end

  private

  # @private
  # @return [Boolean]
  def artist_present?
    params[:artist_id].present?
  end
end
