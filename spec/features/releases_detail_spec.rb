require 'rails_helper'

RSpec.feature "Viewing release details" do
  let :release do
    releases :wonder_bars
  end

  scenario "as a regular user" do
    visit releases_path(release)

    expect(page).to have_css('#release')
    expect(page).to_not have_css('#release .controls')
  end

  scenario "as an admin user" do
    login_as User.admins.first, :scope => :user
    visit releases_path(release)

    expect(page).to have_css('#release')
    expect(page).to have_css('#release .controls')
  end
end
