# Global controller interface, methods here are active throughout the
# application.
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery :with => :exception

  # Return a 404 when a model can't be found.
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found

  # Configure DecentExposure to utilize StrongParameters and decorate
  # all models it returns back.
  decent_configuration { strategy WaxPoetic::DecentExposureStrategy }

  protected
  # The action rendered when a model can't be found.
  def not_found
    render 'errors/not_found', status: 404 and return
  end

  # Formatted errors for the flash.
  def error_msg(model, message="could not be saved")
    "#{model.class.name.titleize} #{message}: #{model.errors.full_messages.join(', ')}"
  end
end
