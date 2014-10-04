require 'rails_helper'

RSpec.describe CreateProductVariants, :type => :job do
  let(:product) { Spree::Product.first }
  let(:release) { releases :give_her_that_rnd }

  subject { CreateProductVariants.perform_now product }

  before { release.update_attributes product: product }

  it "defines the amount of money the price is bumped" do
    expect(subject.class::BUMPS).to be_present
  end

  it "defines the variants we will create" do
    expect(subject.class::VARIANTS).to be_present
    expect(subject.class::VARIANTS).to_not be_empty
  end

  it "bumps the price of the product" do
    expect(subject.send(:price_of, product.price, 'MP3')).to eq(product.price)
    expect(subject.send(:price_of, product.price, 'WAV')).to eq(product.price + 0.59)
    expect(subject.send(:price_of, product.price, 'OSE')).to eq(product.price + 10.00)
  end

  it "calculates the sku for the product" do
    sku = subject.send(:sku_for, product, 'MP3')
    expect(sku).to match(/\AWXP/)
    expect(sku).to match(/MP3\Z/)
  end

  it "finds the release record for this product" do
    expect(subject.send(:release_of, product)).to be_present
  end

  it "calculates option values for the variant" do
    expect(subject.send(:option_values_for, 'MP3')).to_not be_empty
  end

  it "saves each variant" do
    expect(subject.product.variants).to_not be_empty
  end
end
