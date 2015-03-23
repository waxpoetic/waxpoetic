require 'rails_helper'

RSpec.describe SoundcloudPromoter, :type => :promoter do
  subject do
    SoundcloudPromoter.new credentials: {
      client_id: 'test-client-id',
      client_secret: 'test-secret-key'
    }
  end

  let :success do
    double 'Soundcloud::Response', :success? => true
  end

  let :params do
    {
      title: "The Wonder Bars - After Hours [WXP001]",
      asset_data: nil,
      download: false
    }
  end

  before do
    client = double 'Soundcloud'
    allow(client).to receive(:get).with('/me').and_return success
    allow(client).to receive(:post).with('/me/tracks', :track => params).and_return success
    allow(subject).to receive(:soundcloud).and_return client
  end

  let :release do
    releases :just_the_start_ep
  end

  it "validates soundcloud credentials" do
    expect(subject).to be_connected
    expect(subject).to be_valid
  end

  it "promotes a release on soundcloud" do
    expect(subject.promote!(release)).to eq(true)
  end
end
