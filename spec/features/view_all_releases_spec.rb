RSpec.feature "view all releases" do
  before { visit '/releases' }

  xit "renders the title" do
    expect(page).to have_content('<title>Releases | Wax Poetic Records</title>')
  end
end
