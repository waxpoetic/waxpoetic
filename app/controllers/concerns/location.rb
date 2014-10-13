module Location
  extend ActiveSupport::Concern

  included do
    before_action :store_location
  end

  def store_location
    store_location_for :user, request.fullpath
  end

  def after_sign_in_path_for(resource)
    stored_location_for(:user) || root_path
  end
end
