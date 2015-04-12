require 'spec_helper'
require 'wax_poetic/deployment'

module WaxPoetic
  RSpec.describe Deployment, type: :lib do
    subject do
      Deployment.new token: SecureRandom.hex.to_s
    end

    let :url do
      subject.send :url
    end

    let :response do
      double 'Net::HTTPError'
    end

    it 'ensures a circle token is present' do
      subject.token = nil
      expect(subject).not_to be_valid
    end

    it 'validates attributes and saves deployment to circle' do
      allow(subject).to receive(:create).and_return true
      expect(subject).to be_valid
      expect(subject.save).to eq(true)
    end

    it 'computes the url from a token' do
      expect(url).to be_present
    end

    context 'on a successful post to circleci' do
      before do
        allow(response).to receive(:is_a?).with(Net::HTTPSuccess).and_return true
        allow(Net::HTTP).to receive(:post_form).with(url).and_return(response)
      end

      it 'triggers a new build' do
        expect(subject.send(:create)).to eq(true)
      end
    end

    context 'on a failed post to circleci' do
      before do
        allow(Net::HTTP).to receive(:post_form).with(url).and_return(response)
      end

      it 'does not trigger a new build' do
        expect(subject.send(:create)).to eq(false)
      end
    end
  end
end
