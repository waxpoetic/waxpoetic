# Global controller interface, methods here are active throughout the
# application.
class ApplicationController < ActionController::Base
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
