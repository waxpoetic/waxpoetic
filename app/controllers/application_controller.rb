# Global controller interface, methods here are active throughout the
# application.
class ApplicationController < ActionController::Base
  self.responder = Application::Responder
  respond_to :html

  decent_configuration do
    strategy Application::ExposureStrategy
  end

  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found(exception)
    logger.error exception.message
    render :not_found, status: :not_found, error: exception
  end
end
