require 'rails_helper'
require 'wax_poetic/promoter'

module WaxPoetic
  RSpec.describe Promoter do
    subject do
      Promoter.new credentials: "my-only-credential"
    end

    let :test_promoter do
      Promoter.create :test
    end

    let :release do
      releases :just_the_start_ep
    end

    it "validates credentials" do
      expect(subject).to be_valid
    end

    it "saves credentials to a method on init" do
      expect(subject.credentials).to eq("my-only-credential")
    end

    it "saves all given attributes as a hash on init" do
      expect(subject.attributes).to be_a(Hash)
      expect(subject.attributes[:credentials]).to eq("my-only-credential")
    end

    it "raises error when 'promote!' is not implemented" do
      expect { subject.promote!(:nothing) }.to raise_error(NoMethodError)
    end

    it "finds all promoters from configuration" do
      expect(test_promoter).to be_valid
      allow(WaxPoetic.config).to receive(:promote_to).and_return [:test]
      expect(Promoter.all).to include(test_promoter)
      expect(Promoter.any?).to eq(true)
    end

    it "creates a new test_promoter using credentials" do
      expect(test_promoter).to be_a(TestPromoter)
      expect(test_promoter.credentials).to include('api_key')
      expect(test_promoter.credentials).to include('secret_key')
    end

    it "promotes release when 'promote!' is implemented" do
      expect(test_promoter.promote!(release)).to eq(true)
      expect(test_promoter.promoted_releases).to include(release)
    end

    after { test_promoter.reload! }
  end
end
