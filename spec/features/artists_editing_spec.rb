require 'rails_helper'

RSpec.feature "Editing and creating artists" do
  let :artist do
    artists :the_wonder_bars
  end

  scenario "must log in when defining a new artist" do
    visit new_artist_path
    expect(page).to have_content("You need to sign in")
  end

  scenario "must log in before editing an artist" do
    visit edit_artist_path(artist)
    expect(page).to have_content("You need to sign in")
  end

  context "when admin logged in" do
    before do
      login_as User.admins.first, :scope => :user
      visit new_artist_path
    end

    scenario "creates a new artist" do
      within '.new_artist' do
        fill_in 'Name', with: "a new artist"
        fill_in 'Bio', with: "look at my awesome bio"
        click_button 'Create Artist'
      end

      expect(page).to have_content('a new artist')
    end

    scenario "updates an existing artist" do
      login_as User.admins.first, :scope => :user
      visit edit_artist_path(artist)

      fill_in 'Name', with: "new artist name"
      click_button 'Update Artist'

      expect(page).to have_content('new artist name')
    end
  end
end
