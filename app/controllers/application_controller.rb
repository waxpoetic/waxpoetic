# Global controller interface, methods here are active throughout the
# application.
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :exception
end
