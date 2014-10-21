# Represents an Order that is ready for download. Since it's stored in
# the DB, it can always be recalled at a later date if the user still
# wishes to download the files. Through this model, user accounts have a
# record of everything they've ever downloaded, and can initiate
# downloads again at no extra cost.

class Download < ActiveRecord::Base
  belongs_to :order

  has_one :user, :through => :order
  has_many :products, :through => :order

  validates :order, presence: true
  validate :downloadable

  # Since the Spree::Product can't be easily tied back to a Release or
  # Track (blackbox code and all that), we use this method on Download
  # to retrieve what the actual filepath of the resource object is.
  def product_resources
    @product_resources ||= products.map { |product|
      Release.find_by_product_id(product.id) || Track.find_by_product_id(product.id)
    }.select { |result| result.present? }.map do |resource|
      ProductResource.new(resource, self)
    end
  end

  private
  def downloadable
    errors.add :products, "are not downloadable" unless product_resources.any?
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
