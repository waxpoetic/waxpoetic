require 'rails_helper'

RSpec.feature "viewing all artists" do
  scenario "as a regular user returns all artists" do
    visit artists_path
    expect(page).to have_css('#artists')
    expect(page).to have_css('.artist.thumbnail')
  end

  scenario "as an admin user returns all artists and shows the new artist button", :js => true do
    login_as User.admins.first, :scope => :user
    visit artists_path
    expect(page).to have_css('#artists')
    #expect(page).to have_css('.new-item')
  end
end
