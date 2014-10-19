# Global controller interface, methods here are active throughout the
# application.
class ApplicationController < ActionController::Base
  # When a controller uses the `authenticated_resource` macro, it will
  # set up the controller as a standard authenticated RESTful resource
  # for this application. This also sets up the DecentExposure
  # configuration for our controllers.
  include AuthenticatedResource

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
