require 'rails_helper'

RSpec.feature "Viewing artist details" do
  let :admin do
    User.create_admin(
      email: 'test@example.com',
      password: 'password123',
      password_confirmation: 'password123'
    )
  end

  let :artist do
    artists :the_wonder_bars
  end

  scenario "as a regular user" do
    visit artist_path(artist)

    expect(page).to have_content(artist.name)
    expect(page).to have_content(artist.bio.split('. ').first)
    expect(page).to have_content('Releases')
    expect(page).to_not have_content('Edit')
    expect(page).to_not have_content('Delete')
  end

  scenario "as an admin user" do
    login_as admin, :scope => :user
    visit artist_path(artist)

    expect(page).to have_content(artist.name)
    expect(page).to have_content('You are logged in as')
    expect(page).to have_content('Edit')
    expect(page).to have_content('Delete')
  end
end
