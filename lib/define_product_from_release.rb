require 'active_model'

# Defines a Spree::Product from a created Release record.

class DefineProductFromRelease
  include ActiveModel::Model

  attr_accessor :release
  attr_reader :product

  # Imperative shell to the task, could also be refactored into a job if
  # necessary.
  def self.perform(release)
    new(release: release).perform
  end

  # The meat and potatoes of the task, creates the product, variants and
  # associations.
  def perform
    create_product and create_variants and associate_with_release
  end

  protected
  def create_product
    @product ||= Spree::Product.create release.spree_params
  end

  def create_variants
    VARIANTS.each { |variant| send "create_#{variant}" }
  end

  def associate_with_release
    release.update_attributes product: product
  end

  private
  def create_mp3
    product.variants.create \
      price: release.price,
      position: 1
  end

  def create_wav
    product.variants.create \
      price: bump_price(WAV_BUMP),
      position: 2
  end

  def create_ose
    product.variants.create \
      price: bump_price(OSE_BUMP),
      position: 3
  end

  def bump_price(with_bump)
    release.price + with_bump
  end
end
