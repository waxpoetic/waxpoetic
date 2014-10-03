require 'rails_helper'

RSpec.describe ReleasesController, :type => :controller do
  let(:wonder_bars) { artists :wonder_bars }

  it "creates a new release" do
    post :create, release: {
      name: "Falling In Love EP",
      artist_id: wonder_bars.id,
      released_on: 1.day.ago.to_datetime,
      description: "hello i am the description",
      catalog_number: "WXP666",
      cover: files('cover_image.png')
    }

    expect(response).to be_success
    expect(assigns(:release)).to be_valid
    expect(assigns(:release)).to be_persisted
  end
end
