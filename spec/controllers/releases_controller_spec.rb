require 'rails_helper'

RSpec.describe ReleasesController, type: :controller do
  let(:admin) { users :admin }
  let(:wonderbars) { artists :the_wonder_bars }
  let(:release) { releases :just_the_start_ep }
  let :release_params do
    {
      name: 'Rites Of Spring EP',
      released_on: 1.day.ago.to_datetime,
      description: 'hello i am the description',
      catalog_number: 'WXP666',
      image: files('image_image.png'),
      artist_id: wonderbars.id,
      tracks_params: [
        {
          name: 'track 1',
          file: File.new('spec/fixtures/files/track.wav'),
          price: '1.99',
          number: 1
        }
      ]
    }
  end

  it 'has the correct resources' do
    expect(controller.class._singleton_resource).to eq(:release)
    expect(controller.class._collection_resource).to eq(:releases)
  end

  it 'creates a new release after signing in' do
    sign_in admin
    post :create, release: release_params

    expect(response).to be_redirect
    expect(controller.release).to be_valid
    expect(controller.release).to be_persisted
    expect(response).to redirect_to(release_path(id: controller.release.slug))
  end

  it 'does not create a new release when not logged in' do
    post :create, release: release_params
    expect(response).to be_redirect
    expect(response).to redirect_to(new_user_session_path)
    expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
  end

  it 'views all releases' do
    get :index
    expect(response).to be_success
    expect(controller.releases).to_not be_empty
  end

  it 'searches all releases' do
    get :index, name: release.name
    expect(response).to be_success
    expect(controller.releases).to_not be_empty
    expect(controller.releases).to include(release)
  end

  it 'returns an empty set when no results are found' do
    get :index, name: 'not a release'
    expect(response).to be_success
    expect(controller.releases).to be_empty
  end

  it 'views a single release' do
    get :show, id: release.id
    expect(response).to be_success
    expect(controller.release).to be_present
  end

  it 'edits a single release when an admin is logged in' do
    sign_in admin
    get :edit, id: release.id
    expect(response).to be_success
    expect(controller.release).to be_present
  end

  it 'does not allow editing when an admin is not signed in' do
    get :edit, id: release.id
    expect(response).to be_redirect
    expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
  end

  it 'updates a single release' do
    sign_in admin
    put :update, id: release.id, release: { name: 'a new name' }
    expect(response).to be_redirect
    expect(response).to redirect_to(release_path(id: release.catalog_number.parameterize))
    expect(controller.release.name).to eq('a new name')
  end

  it 'does not allow updating unless an admin is logged in' do
    put :update, id: release.id, release: { name: 'a new name' }
    expect(response).to be_redirect
    expect(response).to redirect_to(new_user_session_path)
    expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
  end

  it 'destroys a single release' do
    sign_in admin
    delete :destroy, id: release.id
    expect(response).to be_redirect
    expect(response).to redirect_to(releases_path)
  end

  it 'does not allow deletion unless an admin is logged in' do
    delete :destroy, id: release.id
    expect(response).to be_redirect
    expect(response).to redirect_to(new_user_session_path)
    expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
  end
end
