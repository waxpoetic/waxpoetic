require 'rails_helper'

RSpec.describe ArtistsController, :type => :controller do
  let(:artist) { artists :wonder_bars }
  let(:user) { users :admin }
  let(:image) { File.open("#{Rails.root}/spec/fixtures/files/image.jpg") }

  it "has the correct resources" do
    expect(controller.class._singleton_resource).to eq(:artist)
    expect(controller.class._collection_resource).to eq(:artists)
  end

  it "views a list of all artists" do
    get :index
    expect(response).to be_success
    expect(controller.artists).to_not be_empty
  end

  it "filters list view by name" do
    get :index, name: artist.name
    expect(response).to be_success
    expect(controller.artists).to include(artist)
  end

  it "returns an empty set when name can't be found" do
    get :index, name: 'not-an-artist-name'
    expect(response).to be_success
    expect(controller.artists).to be_empty
  end

  it "views a single artist" do
    get :show, id: artist.id
    expect(response).to be_success
    expect(controller.artist).to eq(artist)
  end

  context "when a user is signed in" do
    before do
      sign_in user
    end

    it "is using an admin user" do
      expect(user.spree_roles).to_not be_empty
      expect(user.spree_roles).to include(Spree::Role.find_by_name('admin'))
      expect(user).to have_spree_role('admin')
      expect(user).to be_admin
    end

    it "creates a new artist" do
      post :create, artist: { name: 'an artist', bio: 'whatever', image: image }
      expect(response.code).to eq('302')
      expect(response).to be_redirect
      expect(controller.artist).to be_valid
      expect(controller.artist).to be_persisted
    end

    it "updates an existing artist" do
      put :update, id: artist.id, artist: { name: 'new name' }
      expect(response).to be_redirect
      expect(controller.artist).to be_valid
      expect(controller.artist.name).to eq('new name')
    end

    it "removes an existing artist" do
      delete :destroy, id: artist.id
      expect(response).to be_redirect
    end
  end

  context "when not logged in" do
    it "does not create a new artist" do
      post :create, artist: { name: 'an artist', bio: 'whatever', image: image }
      expect(response).to be_redirect
    end

    it "does not update artists" do
      put :update, id: artist.id, artist: { name: 'new name' }
      expect(response).to be_redirect
    end

    it "does not destroy artists" do
      delete :destroy, id: artist.id
      expect(response).to be_redirect
    end
  end
end
