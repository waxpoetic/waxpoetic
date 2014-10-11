require 'rails_helper'

RSpec.describe ReleasesController, :type => :controller do
  let(:admin) { users :admin }
  let(:wonderbars) { artists :wonder_bars }
  let :release_params do
    {
      name: "Falling In Love EP",
      released_on: 1.day.ago.to_datetime,
      description: "hello i am the description",
      catalog_number: "WXP666",
      cover: files('cover_image.png'),
      artist_id: wonderbars.id
    }
  end

  before do
    allow(CreateReleaseProduct).to receive(:enqueue).and_return true
    allow(PackageRelease).to receive(:enqueue).and_return true
  end

  it "creates a new release after signing in" do
    sign_in admin
    post :create, release: release_params

    expect(response).to be_redirect
    expect(controller.release).to be_valid
    expect(controller.release).to be_persisted
    expect(response).to redirect_to(release_path(id: controller.release.id))
  end

  it "does not create a new release when not logged in" do
    post :create, release: release_params
    expect(response).to be_redirect
    expect(response).to redirect_to(new_user_session_path)
    expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
  end
end
