require 'rails_helper'

RSpec.describe PackageRelease, :type => :job do
  let(:release) { releases :just_the_start }
  let(:track) do
    double 'Track', \
      :file => double('MusicUploader', :path => 'track.wav')
  end

  before do
    allow(release).to receive(:tracks).and_return [track]
  end

  subject { PackageRelease.perform_now release }

  it "builds a zip package of the tracks in this release" do
    expect(subject.last_command).to match(/\Atar -czf/)
    expect(subject.last_command).to include("#{release.decorate.filename}.zip")
    expect(subject.last_command).to include(track.file.path)
  end
end
