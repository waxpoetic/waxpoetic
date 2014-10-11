class EventsController < ApplicationController
  respond_to :html
  before_action :authenticate_user!, except: %w(index show)
  expose :events, only: %w(index)
  expose :event, :attributes => :edit_params, except: %w(index)

  def index
    respond_with events
  end

  def show
    respond_with event
  end

  def new
    render :new
  end

  def edit
    render :edit
  end

  def create
    if event.save
      respond_with event, notice: "New event created."
    else
      redirect_to new_event_path, alert: "Couldn't create event."
    end
  end

  def update
    if event.update_attributes edit_params
      respond_with event, notice: "Event has been updated."
    else
      redirect_to edit_event_path(event), alert: "Couldn't update event."
    end
  end

  def destroy
    if event.destroy
      respond_with event, notice: "Event has been deleted."
    else
      redirect_to :edit, alert: "Couldn't delete event."
    end
  end

  private
  def search_params
    params.permit *event_params.merge(:latitude, :longitude)
  end

  def edit_params
    params.require(:event).permit *event_params
  end

  def event_params
    [:name, :location, :description, :starts_at, :ends_at, :ticket_price]
  end
end
