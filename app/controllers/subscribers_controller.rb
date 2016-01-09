class SubscribersController < ApplicationController
  resource :subscriber

  def new
    render :new
  end

  def create
    subscriber.attributes = permitted_params(subscriber)
    subscriber.save
    respond_with subscriber, notice: t(:thanks)
  end

  def show
    respond_with subscriber
  end
end
