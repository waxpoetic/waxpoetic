require 'rails_helper'

RSpec.describe SoundcloudPromoter, :type => :promoter do
  subject do
    SoundcloudPromoter.new credentials: {
      client_id: 'test-client-id',
      client_secret: 'test-secret-key'
    }
  end

  let :release do
    releases :falling_in_love
  end

  it "validates soundcloud credentials" do
    expect(subject).to be_valid
  end

  it "promotes a release on soundcloud" do
    expect(subject.promote!(release)).to eq(true)
  end
end
