# Global controller interface, methods here are active throughout the
# application. Typically used for controller configuration, this class
# sets up all other controllers for our architecture...such as
# configuring +DecentExposure+ and +Responders+, exposing a
# +Release.latest+ call, and rescuing exceptions using standard HTTP
# error responses.
class ApplicationController < ActionController::Base
  include Halt

  self.responder = Application::Responder
  respond_to :html, :json

  decent_configuration do
    strategy Application::ExposureStrategy
  end

  protect_from_forgery with: :exception

  expose :releases, scope: :latest

  halt ActiveRecord::RecordNotFound, with: :not_found
end
