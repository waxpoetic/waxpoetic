module ApplicationHelper
  # Return the name of the CSS class for the given flash message type.
  def flash_class_for(flash_type)
    case flash_type
    when 'notice'
      'success'
    else
      flash_type
    end
  end

  # Test whether the current user is logged in and an admin.
  def admin_signed_in?
    user_signed_in? && current_user.admin? rescue false
  end
end
