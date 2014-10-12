# Error handling methods and controller configuration to handle forgery.
module Errors
  extend ActiveSupport::Concern

  included do
    # Prevent CSRF attacks by raising an exception.
    protect_from_forgery :with => :exception

    # Return a 404 when a model can't be found.
    rescue_from ActiveRecord::RecordNotFound, :with => :not_found
  end

  # A helper to format errors for the flash.
  def error_msg(model, message="could not be saved")
    "#{model.class.name.titleize} #{message}: #{model.errors.full_messages.join(', ')}"
  end

  protected
  # The action rendered when a model can't be found.
  def not_found
    render 'errors/not_found', status: 404 and return
  end
end
