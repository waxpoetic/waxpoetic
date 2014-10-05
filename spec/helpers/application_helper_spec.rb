require 'rails_helper'

RSpec.describe ApplicationHelper, :type => :helper do
  context "#nav_item" do
    it "just renders the link when not an admin" do
      allow(helper).to receive(:admin_signed_in?).and_return false
      expect(helper.nav_item(:releases)).to eq(%(<li><a href="/releases">Releases</a></li>))
    end

    it "renders the link and dropdown when admin is present" do
      allow(helper).to receive(:admin_signed_in?).and_return true
      expect(helper.nav_item(:releases)).to include(%(<li class="has-dropdown"><a href="/releases">Releases</a>))
      expect(helper.nav_item(:releases)).to include(%(<ul class="dropdown">))
    end
  end
end
