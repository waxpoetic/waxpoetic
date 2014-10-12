# Methods for determining whether to render with or without a layout. We
# render the layout if we're making an XmlHttpRequest and not passing
# the Turbolinks header.
module Ajax
  extend ActiveSupport::Concern

  included do
    layout :use_layout?
  end

  def use_layout?
    return false if request.xhr?
    'application'
  end
end
