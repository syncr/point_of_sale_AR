require 'spec_helper'

describe Customer do
  before do
    setup
  end

  it {should have_many :sales}

  it "exists in the customer table" do
    @test_customer.save
    expect(Customer.all).to eq [@test_customer]
  end
end
