module DownloadsHelper
  def download_link_to(product)
    link_to product.name, authenticated_download_path(product)
  end

  def authenticated_download_path(product)
    resource = product_resource(product)
    return '#' unless resource.present?

    resource.file.url + '?' + authorize_download(current_user, resource)
  end

  private
  def product_resource(product)
    release_for(product) || track_for(product)
  end

  def release_for(product)
    Release.find_by_product_id product.id
  end

  def track_for(product)
    Track.find_by_product_id product.id
  end
end
