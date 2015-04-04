require 'rails_helper'

RSpec.describe Saleable, type: :concern do
  subject { releases :shuffle_not }

  it "exposes certain attributes to create a Spree::Product" do
    expect(subject.product_attributes).to be_present
    expect(subject.product_attributes.stringify_keys.keys).to eq(%w(
      name
      description
      meta_description
      available_on
      shipping_category
    ))
  end

  it "should use the default shipping category" do
    expect(subject.shipping_category).to be_present
    expect(subject.shipping_category.name).to eq('Default')
  end
end
