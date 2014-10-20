module ApplicationHelper
  # Controllers that are thought of as the '#store' in the page ID.
  SPREE_CONTROLLERS = %w(products)

  # Return the product's file URL. Only works on Spree.
  def download
    Download.find_by_order_id @order.id
  end

  # An `<li>` that wraps an `<a>`, used for rendering nav links that
  # could optionally have a dropdown.
  def nav_item(route, text=nil)
    text ||= route.to_s.titleize
    content_tag :li do
      link_to text, "/#{route}"
    end
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
    case
    when SPREE_CONTROLLERS.include?(controller.controller_name)
      'store'
    when controller.controller_name == 'podcasts'
      'podcast'
    else
      controller.controller_name
    end
  end

  def gallery_for(resources)
    render 'gallery', resources: resources
  end
end
