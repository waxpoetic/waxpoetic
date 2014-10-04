require 'rails_helper'

RSpec.describe TitleHelper, :type => :helper do
  it "renders the title tag with the app title by default" do
    expect(helper.title_tag).to eq("<title>Wax Poetic Records</title>")
  end

  it "renders the title tag with a page title when set" do
    helper.title('Page')
    expect(helper.title_tag).to eq("<title>Page | Wax Poetic Records</title>")
  end

  it "renders the title tag and an <h1> with a page title when set" do
    expect(helper.title('Page')).to eq("<h1>Page</h1>")
  end
end
