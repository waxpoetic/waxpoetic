require 'rails_helper'

RSpec.describe CreateReleaseProduct, :type => :job do
  let(:release) { releases :falling_in_love }

  before { allow(CreateProductVariants).to receive(:enqueue) }

  subject { CreateReleaseProduct.perform_now release }

  it "creates a new product" do
    expect(subject.product).to be_present
    expect(subject.product).to be_valid
    expect(subject.product).to be_persisted
  end

  it "assigns the product to the release" do
    expect(subject.release.product).to be_present
    expect(subject.release.product).to eq(subject.product)
    expect(subject.release.product.images).to_not be_empty
  end
end
