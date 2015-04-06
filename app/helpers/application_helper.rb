module ApplicationHelper
  # Controllers that are thought of as the '#store' in the page ID.
  SPREE_CONTROLLERS = %w(products)

  # Return the product's file URL. Only works on Spree.
  def download
    Download.find_by_order_id @order.id
  end

  def current?(route)
    if route == :store
      current_page? store.root_path
    else
      current_page? main_app.send("#{route}_path")
    end
  end

  # An `<li>` that wraps an `<a>`, used for rendering nav links that
  # could optionally have a dropdown.
  def nav_item(route, options = {}, &block)
    text ||= route.to_s.titleize
    css = if current? route
      [options[:class], 'active'].join(' ')
    else
      options[:class]
    end
    link = link_to text.downcase, "/#{route}"

    content_tag :li, class: css do
      if block_given?
        link + capture(&block).html_safe
      else
        link.html_safe
      end
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
