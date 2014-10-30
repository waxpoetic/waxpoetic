require 'spec_helper'
require 'wax_poetic/temporary_policy'

module WaxPoetic
  RSpec.describe TemporaryPolicy do
    subject do
      TemporaryPolicy.new(
        name: 'fake-session-1',
        path: 'files.waxpoeticrecords.com/downloads/track.wav'
       )
    end

    let :creds do
      {
        session_token: 'token',
        access_key_id: 'key',
        secret_access_key: 'secret'
      }
    end

    let :mock_sts do
      sts = double 'AWS::STS'
      allow(sts).to \
        receive(:new_federated_session)
          .with(subject.name, subject.send(:options))
          .and_return(
            double('AWS::STS::Session', credentials: creds)
          )
      sts
    end

    before do
      allow(subject).to receive(:sts).and_return mock_sts
    end

    it "finds credentials from session data" do
      expect(subject.credentials).to_not be_empty
    end

    it "turns credentials into query params" do
      expect(subject.params).to include('&')
    end
  end
end
