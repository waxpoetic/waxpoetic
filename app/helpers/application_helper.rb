module ApplicationHelper
  def nav_item(route, text=nil)
    text ||= route.to_s.titleize
    link = link_to text, send("#{route}_path")
    content = if current_user.admin?
      concat link, dropdown_for(route, text)
    else
      link
    end
    content_tag :li, content, nav_item_options
  end

  # Test whether the current user is logged in and an admin.
  def admin_present?
    current_user.present? && current_user.admin?
  end

  private
  def dropdown?
    { :class => 'has-dropdown' } if admin_present?
  end

  def dropdown_for(route, text)
    render 'admin_dropdown', locals: {
      route: route,
      resource: text
    }
  end
end
