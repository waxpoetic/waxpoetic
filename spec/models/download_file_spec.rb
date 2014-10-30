require 'rails_helper'

RSpec.describe DownloadFile, :type => :model do
  let :resource do
    tracks :after_hours
  end

  let :download do
    double 'Download', id: 1
  end

  before do
    allow(resource.file).to receive(:url).and_return 'http://files.waxpoeticrecords.com/tracks/1/files/track.wav'
  end

  subject { DownloadFile.new resource, download }

  it "returns the title as its name" do
    expect(subject.name).to eq(resource.decorate.title)
  end

  it "computes a valid uri" do
    allow(subject).to receive(:session_credentials).and_return(
      session_token: 'token',
      access_key_id: 'key',
      secret_access_key: 'secret'
    )
    expect(subject.to_url).to include(subject.resource.file.url)
    expect(subject.to_url).to include('SessionToken=token')
    expect(subject.to_url).to include('AccessKeyId=key')
    expect(subject.to_url).to include('SecretAccessKey=secret')
    expect { URI.parse subject.to_url }.to_not raise_error
  end
end
