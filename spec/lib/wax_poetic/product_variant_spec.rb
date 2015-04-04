require 'spec_helper'
require 'wax_poetic/product_variant'

module WaxPoetic
  RSpec.describe ProductVariant do
    let :release do
      releases :shuffle_not
    end

    let :product do
      Product.for release
    end

    let :variant do
      'WAV'
    end

    subject do
      ProductVariant.new product: product, type: variant
    end

    it "stores given params as attributes" do
      expect(subject.saleable).to eq(release)
      expect(subject.type).to eq(variant)
    end

    it "defines the amount of money the price is bumped" do
      expect(ProductVariant::BUMPS).to be_present
      expect(ProductVariant::BUMPS.keys).to_not be_empty
    end

    it "defines the variants we will create" do
      expect(ProductVariant::TYPES).to be_present
      expect(ProductVariant::TYPES).to_not be_empty
    end

    it "bumps the price of the product" do
      expect(subject.price).to eq(release.price + ProductVariant::BUMPS[variant])
    end

    it "calculates the sku for the product" do
      expect(subject.sku).to eq("#{release.catalog_number}-#{variant}")
    end

    it "packages attributes into a hash" do
      expect(subject.attributes).to be_a(Hash)
    end

    it "fetches spree options values from the format option" do
      expect(subject.option_values).to_not be_empty
    end
  end
end
