require 'rails_helper'

RSpec.describe CreateProductVariants, :type => :job do
  let(:release) { releases :shuffle_not }
  let(:product) { FactoryGirl.create :product, saleable: release }

  subject { CreateProductVariants }

  it "creates product variants" do
    expect { subject.perform_now(product) }.to_not raise_error
  end
end
