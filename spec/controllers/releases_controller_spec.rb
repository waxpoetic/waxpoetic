require 'rails_helper'

RSpec.describe ReleasesController, :type => :controller do
  let(:wonder_bars) { artists :wonder_bars }

  it "creates a new release" do
    allow(CreateReleaseProduct).to receive(:enqueue).and_return true
    allow(PackageRelease).to receive(:enqueue).and_return true

    post :create, artist_id: wonder_bars.id, release: {
      name: "Falling In Love EP",
      released_on: 1.day.ago.to_datetime,
      description: "hello i am the description",
      catalog_number: "WXP666",
      cover: files('cover_image.png')
    }

    expect(response).to be_redirect
    expect(assigns(:release)).to be_valid
    expect(assigns(:release)).to be_persisted
    expect(response).to redirect_to(release_path(assigns(:release)))
  end
end
