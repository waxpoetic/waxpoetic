require 'rails_helper'

RSpec.describe ApplicationHelper, :type => :helper do
  context "#nav_item" do
    it "renders the admin link" do
      expect(helper.nav_item(:releases)).to eq(%(<li><a href="/releases">releases</a></li>))
    end
  end
end
