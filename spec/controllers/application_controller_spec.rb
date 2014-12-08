require 'rails_helper'

RSpec.describe ApplicationController, :type => :controller do
  let :request do
    double 'Rack::Request', :xhr? => nil
  end

  before do
    allow(subject).to receive(:request).and_return request
  end

  it "uses layout for normal browser requests" do
    allow(request).to receive(:xhr?).and_return false
    expect(subject.send(:use_layout?)).to eq('application')
  end

  it "disables layout for xhr requests" do
    allow(request).to receive(:xhr?).and_return true
    expect(subject.send(:use_layout?)).to eq(false)
  end
end
