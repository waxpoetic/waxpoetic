module StoreHelper
  def spree_logo
    image_tag Spree::Config[:logo], class: 'logo'
  end
end
