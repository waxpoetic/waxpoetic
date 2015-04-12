require 'rails_helper'

RSpec.describe PackageReleaseJob, :type => :job do
  let(:release) { releases :just_the_start_ep }
  let(:track) { tracks :after_hours }

  subject { PackageReleaseJob }

  it "builds a zip package of the tracks in this release" do
    expect { subject.perform_now(release) }.to_not raise_error
  end
end
