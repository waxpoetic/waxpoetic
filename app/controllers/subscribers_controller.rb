# API for subscribing new users to the
class SubscribersController < ApplicationController
  resource :subscriber

  # Form for new subscribers, typically rendered asynchronously within a
  # modal dialog. This can also be used, unstyled, by an +Artist+ site
  # to render a subscribe form on their page by passing the artist ID in
  # the route as shown below:
  #
  # @http [GET] /subscribers/new
  # @http [GET] /artists/the-wonder-bars/subscribers/new
  def new
    render :new
  end

  # Create a new +Subscriber+, and by definition subscribe this person
  # to the list for their chosen +Artist+. If an +artist_id+ is not
  # provided, assume this request is coming from the main site form and
  # subscribe this user to the general Wax Poetic shout list.
  #
  # @http [POST] /subscribers.json
  # @example
  #   {
  #     "subscriber": {
  #       "name": "John Doe",
  #       "email": "john@example.com"
  #       "artist_id": 1
  #     }
  #   }
  def create
    subscriber.attributes = permitted_params(subscriber)
    subscriber.save
    respond_with subscriber
  end

  # View information on a given +Subscriber+, or if on the front-end,
  # render the "thank you" content that shows up in the dialog.
  #
  # @http [GET] /subscribers/1.json
  def show
    respond_with subscriber
  end
end
