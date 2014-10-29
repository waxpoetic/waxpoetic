require 'rails_helper'

RSpec.feature "Viewing all artists" do
  scenario "as a regular user" do
    visit artists_path

    expect(page).to have_css('#artists')
    expect(page).to have_css('.artist.thumbnail')
    expect(page).to_not have_css('.admin')
  end

  scenario "as an admin user" do
    login_as User.admins.first, :scope => :user
    visit artists_path

    expect(page).to have_css('#artists')
    expect(page).to have_content('You are logged in as')
    expect(page).to have_css('.admin')
  end
end
