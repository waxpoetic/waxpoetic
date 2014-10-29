require 'rails_helper'

RSpec.feature "Viewing release details" do
  let :release do
    releases :just_the_start
  end

  scenario "as a regular user" do
    skip "until we solve the css issue"
    visit release_path(release)

    expect(page).to have_content('You are not signed in')
    expect(page).to have_css('#release')
    expect(page).to have_css('#release .properties')
    expect(page).to have_css('#release .tracks')
    expect(page).to have_css('#release .photo')
    expect(page).to have_css('#release .description')
    expect(page).to_not have_css('#release .admin.controls')
  end

  scenario "as an admin user" do
    login_as User.admins.first, :scope => :user
    visit release_path(release)

    expect(page).to have_css('#release')
    expect(page).to have_css('#release .properties')
    expect(page).to have_css('#release .tracks')
    expect(page).to have_css('#release .photo')
    expect(page).to have_css('#release .description')
    expect(page).to have_css('#release .admin.controls')
  end
end
