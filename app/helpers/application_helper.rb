module ApplicationHelper
  def flash_class_for(flash_type)
    case flash_type
    when 'notice'
      'success'
    else
      flash_type
    end
  end

  def nav_item(route, text=nil, always_show_dropdown: false)
    text ||= route.to_s.titleize
    link = link_to text, "/#{route}"
    show_dropdown = always_show_dropdown || admin_signed_in?
    content = if show_dropdown
      link.concat nav_item_dropdown_for(route, text)
    else
      link
    end
    options = { :class => 'has-dropdown' } if show_dropdown

    content_tag :li, content, options
  end

  def dropdown_item(name, route, options={})
    content_tag :li do
      link_to name, route, options
    end
  end

  # Test whether the current user is logged in and an admin.
  def admin_signed_in?
    user_signed_in? && current_user.admin? rescue false
  end

  private
  def nav_item_dropdown_for(route, text)
    partial = if has_dropdown? route
      "#{route}_dropdown"
    else
      'admin_dropdown'
    end
    render partial, route_name: route, resource_name: text
  end

  def has_dropdown?(route)
    File.exist? "#{Rails.root}/app/views/application/_#{route}_dropdown.html.erb"
  end
end
