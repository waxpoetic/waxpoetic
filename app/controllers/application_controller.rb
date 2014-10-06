class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery :with => :exception

  rescue_from ActiveRecord::RecordNotFound, :with => :not_found

  decent_configuration do
    strategy DecoratedStrongParametersStrategy
  end

  protected
  def not_found
    render 'errors/not_found', status: 404 and return
  end
end
