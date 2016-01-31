# API for finding +Release+s, either by an +Artist+ or just the entire
# catalog.
#
# @api Releases
class ReleasesController < ApplicationController
  expose :artist
  resource :release, ancestor: :artist, if: :artist_present?
  resource :release, unless: :artist_present?

  # View all releases, either by a given +Artist+ or the entire catalog.
  #
  # @http [GET] /releases.json
  # @http [GET] /artists/the-wonder-bars/releases.json
  def index
    respond_with releases
  end

  # View a single release.
  #
  # @http [GET] /releases/WXP005.json
  def show
    respond_with release
  end

  private

  # Check if an +Artist+ is given before trying to look up the release
  # by its +Artist+.
  #
  # @private
  # @return [Boolean]
  def artist_present?
    params[:artist_id].present?
  end
end
