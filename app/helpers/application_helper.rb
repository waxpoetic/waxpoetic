module ApplicationHelper
  def social_media_icons
    Rails.configuration.social_media_urls.slice(:facebook, :twitter, :soundcloud, :spotify)
  end

  # An `<li>` that wraps an `<a>`, used for rendering nav links that
  # could optionally have a dropdown.
  def nav_item(name, route = nil)
    route ||= send("#{name}_path")
    css = 'active' if request.env['PATH_INFO'] =~ /#{route}/

    content_tag :li, class: css do
      link_to route do
        translate ".#{name}"
      end
    end
  end
end
