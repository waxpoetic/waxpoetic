require 'rails_helper'

RSpec.describe CreateProductVariants, :type => :job do
  let(:release) { releases :give_her_that_rnd }
  let :product do
    Spree::Product.new price: 1.00
  end

  subject { CreateProductVariants.perform_now product }

  before do
    allow(release).to receive(:product_id).and_return 1
    allow(release).to receive(:product).and_return product
  end

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

  xit "finds the release record for this product" do
    expect(subject.send(:release_of, product)).to be_present
  end

  xit "saves each variant" do
    expect(product.variants).to_not be_empty
  end
end
