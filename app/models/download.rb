# Represents an Order that is ready for download. Since it's stored in
# the DB, it can always be recalled at a later date if the user still
# wishes to download the files. Through this model, user accounts have a
# record of everything they've ever downloaded, and can initiate
# downloads again at no extra cost.

class Download < ActiveRecord::Base
  belongs_to :order, class_name: 'Spree::Order'

  has_one :user, :through => :order

  validates :order, presence: true
  validate :downloadable

  # Since the Spree::Product can't be easily tied back to a Release or
  # Track (blackbox code and all that), we use this method on Download
  # to retrieve what the actual filepath of the resource object is.
  def files
    @files ||= order.variants.map { |variant|
      if resource = product_resource_for(variant.product)
        DownloadFile.new \
          download: self,
          product: variant.product,
          resource: resource,
          variant: variant
      end
    }.select(&:present?)
  end

  private
  def downloadable
    errors.add :products, "are not downloadable" unless files.any?
  end

  def product_resource_for(product)
    Release.find_by_product_id(product.id) ||
    Track.find_by_product_id(product.id)
  end
end

# == Schema Information
#
# Table name: downloads
#
#  id         :integer          not null, primary key
#  order_id   :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_downloads_on_order_id  (order_id)
#
