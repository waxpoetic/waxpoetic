class SubscribersController < ApplicationController
  resource :subscriber

  def new
    render :new
  end

  def create
    subscriber.attributes = edit_params
    subscriber.save
    respond_with subscriber
  end

  def show
    respond_with subscriber
  end

  private

  def edit_params
    params.require(:subscriber).permit :name, :email
  end
end
