class EventsController < ApplicationController
  resource :event do
    search :name, :location, :description, :starts_at, :ends_at, :ticket_price, :latitude, :longitude
    modify :name, :location, :description, :starts_at, :ends_at, :ticket_price
  end

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
    event.save
    respond_with event
  end

  def update
    event.update_attributes edit_params
    respond_with event
  end

  def destroy
    event.destroy
    respond_with event
  end
end
