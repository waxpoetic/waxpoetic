require 'rails_helper'

RSpec.feature 'Viewing all releases' do
  let :admin do
    User.create_admin(
      email: 'test@example.com',
      password: 'password123',
      password_confirmation: 'password123'
    )
  end

  scenario 'as a regular user' do
    visit releases_path

    expect(page).to have_content('Releases')
    expect(page).to_not have_content('New Release')
  end

  scenario 'as an admin user' do
    login_as admin, scope: :user
    visit releases_path

    expect(page).to have_content('Releases')
    expect(page).to have_content('You are logged in as')
    expect(page).to have_content('New Release')
  end
end
