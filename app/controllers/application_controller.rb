# Global controller interface, methods here are active throughout the
# application.
class ApplicationController < ActionController::Base
  self.responder = Application::Responder
  respond_to :html

  decent_configuration do
    strategy Application::ExposureStrategy
  end

  # Prevent CSRF attacks by showing a null session.
  protect_from_forgery with: :null_session

  halt ActiveRecord::RecordNotFound, with: :not_found

  def not_found(exception)
    logger.error exception.message
    render :not_found, status: :not_found, error: exception
  end
end
