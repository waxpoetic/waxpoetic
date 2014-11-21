require 'rails_helper'

RSpec.describe PackageRelease, :type => :job do
  let(:release) { releases :just_the_start }
  let(:track) { tracks :after_hours }

  subject { PackageRelease }

  it "builds a zip package of the tracks in this release" do
    expect { subject.perform_now(release) }.to_not raise_error
  end
end
