require 'rails_helper'

RSpec.feature "Viewing all releases" do
  scenario "as a regular user" do
    visit releases_path

    expect(page).to have_css('#releases')
    expect(page).to have_css('.release.thumbnail')
    expect(page).to_not have_css('.admin')
  end

  scenario "as an admin user" do
    login_as User.admins.first, :scope => :user
    visit releases_path

    expect(page).to have_css('#releases')
    expect(page).to have_content('You are logged in as')
    expect(page).to have_css('.admin')
  end
end
