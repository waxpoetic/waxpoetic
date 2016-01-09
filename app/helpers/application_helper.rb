module ApplicationHelper
  # An `<li>` that wraps an `<a>`, used for rendering nav links that
  # could optionally have a dropdown.
  def nav_item(route, text=nil)
    text ||= route.to_s.titleize
    css = 'active' if request.env['PATH_INFO'] =~ /#{route}/

    content_tag :li, class: css do
      link_to text.downcase, "/#{route}"
    end
  end

  def current_route
  end

  # Configure a link_to to open in a reveal lightbox.
  def reveal_link_to(name, route, options={})
    link_to name, route, options.merge(
      data: {
        reveal_ajax: true,
        reveal_id: 'lightbox',
        no_turbolinks: true
      }
    )
  end

  def destroy_link_to(name, route, options={})
    link_to name, route, options.merge(:method => :delete)
  end

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
    user_signed_in? && current_user.try(:admin?)
  end

  # The HTML properties used for the `<section>` tag available on every
  # page. Marks the current controller.
  def page_tag_properties
    {
      id: page_id,
      class: 'page row'
    }
  end

  def page_id
    if SPREE_CONTROLLERS.include?(controller.controller_name)
      'store'
    else
      controller.controller_name
    end
  end

  def gallery_for(resources)
    render 'gallery', resources: resources
  end
end
