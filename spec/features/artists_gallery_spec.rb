require 'rails_helper'

RSpec.feature "Viewing all artists" do
  let :admin do
    User.create_admin(
      email: 'test@example.org',
      password: 'password123',
      password_confirmation: 'password123',
    )
  end

  let :artist do
    artists :the_wonder_bars
  end

  scenario "as a regular user just renders all images" do
    visit artists_path

    expect(page).to have_content('Artists')
    expect(page).to_not have_content('New Artist')
  end

  scenario "as an admin user renders the new button" do
    login_as admin, :scope => :user
    visit artists_path

    expect(page).to have_content('Artists')
    expect(page).to have_content('You are logged in as')
    expect(page).to have_content('New Artist')
  end
end
