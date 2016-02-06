# View information on events related to an artist.
class EventsController < ApplicationController
  expose :artist
  resource :event, ancestor: :artist

  # View all upcoming events for a given +Artist+.
  #
  # @http [GET] /artists/:name/events
  def index
    respond_with events
  end

  # View a single event.
  #
  # @http [GET] /artists/:artist_id/events/:id
  def show
    respond_with event
  end
end
