module ApplicationHelper
  def nav_item(route, text=nil)
    text ||= route.to_s.titleize
    link = link_to text, send("#{route}_path")

    content = if admin_signed_in?
      link.concat nav_item_dropdown_for(route, text)
    else
      link
    end

    content_tag :li, content, nav_item_options
  end

  # Test whether the current user is logged in and an admin.
  def admin_signed_in?
    user_signed_in? && current_user.admin? rescue false
  end

  private
  def nav_item_options
    { :class => 'has-dropdown' } if admin_signed_in?
  end

  def nav_item_dropdown_for(route, text)
    render 'admin_dropdown', \
      route_name: route,
      resource_name: text
  end
end
