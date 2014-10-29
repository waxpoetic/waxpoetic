require 'rails_helper'

RSpec.feature "Viewing artist details" do
  let :artist do
    artists :wonder_bars
  end

  scenario "as a regular user" do
    visit artist_path(artist)

    expect(page).to have_css('#artist')
    expect(page).to have_css('#artist .bio')
    expect(page).to have_css('#artist .releases')
    expect(page).to_not have_css('#artist .admin.controls')
  end

  scenario "as an admin user" do
    login_as User.admins.first, :scope => :user
    visit artist_path(artist)

    expect(page).to have_css('#artist')
    expect(page).to have_content('You are logged in as')
    expect(page).to have_css('#artist .admin.controls')
  end
end
