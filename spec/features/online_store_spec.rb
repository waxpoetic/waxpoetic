require 'rails_helper'

RSpec.feature 'Viewing the online store' do
  before { visit '/store' }

  scenario 'still renders the app layout' do
    expect(page).to have_css('header')
    expect(page).to have_css('section.page')
    expect(page).to have_css('footer')
  end
end
