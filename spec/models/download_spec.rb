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

require 'rails_helper'

RSpec.describe Download, :type => :model do
  let :user do
    users :admin
  end

  let :release do
    FactoryGirl.create :release
  end

  let :product do
    FactoryGirl.create :product, variants: [FactoryGirl.create(:variant)]
  end

  let :variant do
    product.variants.first
  end

  let :order do
    FactoryGirl.create :order, user: user, variants: [variant]
  end

  subject { Download.new order: order }

  before do
    allow(order).to receive(:downloadables).and_return([variant])
    allow(product).to receive(:saleable).and_return(release)
    allow(subject).to receive(:product_resource_for).and_return product
  end

  it "validates an order is present" do
    expect(subject).to be_valid
  end

  it "uses the users email address" do
    expect(subject.user).to eq(user)
  end

  it "finds a resource for each product" do
    expect(subject.files).to_not be_empty
  end
end
