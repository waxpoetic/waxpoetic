require 'rails_helper'

RSpec.feature 'Editing and creating releases' do
  let :release do
    releases :just_the_start_ep
  end

  scenario 'must log in when defining a new release' do
    visit new_release_path
    expect(page).to have_content('You need to sign in')
  end

  scenario 'must log in before editing an release' do
    visit edit_release_path(release)
    expect(page).to have_content('You need to sign in')
  end

  context 'when admin logged in' do
    before do
      login_as User.admins.first, scope: :user
      visit new_release_path
    end

    scenario 'creates a new release' do
      within '.new_release' do
        fill_in 'Name', with: 'a new release'
        select 'The Wonder Bars', from: 'Artist'
        select 'January', from: 'release_released_on_2i'
        select '3', from: 'release_released_on_3i'
        select '2014', from: 'release_released_on_1i'
        fill_in 'Catalog number', with: 'WXP-1337'
        attach_file 'Image', "#{Rails.root}/app/assets/images/logo.jpg"
        fill_in 'Description', with: 'this is the description'
        click_button 'Create Release'
      end

      expect(page).to_not have_css('#flash .alert')
      expect(page).to have_content('a new release')
    end

    scenario 'updates an existing release' do
      login_as User.admins.first, scope: :user
      visit edit_release_path(release)

      fill_in 'Name', with: 'new release name'
      click_button 'Update Release'

      expect(page).to_not have_css('#flash .alert')
      expect(page).to have_content('new release name')
    end
  end
end
