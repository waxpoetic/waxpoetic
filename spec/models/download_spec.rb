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

  let :order do
    FactoryGirl.create :order, user: user
  end

  let :mock_session do
    double 'AWS::STS::FederatedSession', credentials: {
      aws_access_key_id: 'access-key',
      aws_secret_access_key: 'secret-key'
    }
  end

  subject { Download.new order: order }

  before do
    allow(subject.send(:sts)).to receive(:new_federated_session).and_return mock_session
    allow(Release).to receive(:find_by_product_id).with(14).and_return release
  end

  it "validates an order is present" do
    expect(subject).to be_valid
  end

  it "uses the users email address" do
    expect(subject.user).to eq(user)
  end

  it "uses the products as resources" do
    expect(subject.products).to include(product)
  end

  it "finds a resource for each product" do
    expect(subject.product_resources).to include(release)
  end

  it "generates an authenticated url for a product" do
    expect(subject.url_for(release)).to_not be_nil
  end
end
