require 'rails_helper'

RSpec.feature "Viewing static pages" do
  scenario "home page is the root path" do
    visit root_path
    expect(page).to have_css('#pages')
  end

  scenario "about page renders the mission statement" do
    visit page_path('about')
    expect(page).to have_css('#pages')
    expect(page).to have_content('Powered By Open Source')
  end

  scenario "contact page renders contact info" do
    visit page_path('contact')
    expect(page).to have_css('#pages')
    expect(page).to have_content('Contact Us')
  end

  scenario "license renders the license as text" do
    visit page_path('license')
    expect(page).to have_css('#pages')
    expect(page).to have_css('#license')
  end
end
