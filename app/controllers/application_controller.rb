# Global controller interface, methods here are active throughout the
# application.
class ApplicationController < ActionController::Base
  # When using the `resource` macro in a controller class definition, it will
  # set up that controller as a standard authenticated RESTful resource
  # for this application. This module also sets up the DecentExposure
  # and Responders configuration for our controllers.
  include ControllerResource

  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery :with => :exception

  # Determine whether to render the layout based on whether the current
  # request was made with the XmlHttpRequest object in JavaScript.
  layout :use_layout?

  private
  def use_layout?
    return false if request.xhr?
    'application'
  end
end
