require 'spec_helper'

describe PodcastDecorator do
  let :podcast do
    podcasts :one
  end

  subject { PodcastDecorator.decorate podcast }

  it "renders description as markdown" do
    expect(subject.description).to include('<strong>episode</strong>')
  end
end
