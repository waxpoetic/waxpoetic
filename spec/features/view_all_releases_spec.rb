RSpec.feature "view all releases" do
  before { visit '/releases' }

  it "renders the title" do
    expect(page).to have_content('<h2>Releases</h2>')
    expect(page).to have_content('<title>Releases | Wax Poetic Records</title>')
  end
end
