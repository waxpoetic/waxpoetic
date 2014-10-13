# Global controller interface, methods here are active throughout the
# application.
class ApplicationController < ActionController::Base
  include Errors
  include Ajax
  include Location

  # Configure DecentExposure to utilize StrongParameters and decorate
  # all models it returns back.
  decent_configuration { strategy WaxPoetic::DecentExposureStrategy }
end
