require "spec_helper"

describe Product do
  before do
    setup
  end

  it {should have_many :purchases}
  it {should have_many(:sales).through(:purchases)}

  it "will store products in the DB" do
    expect(Product.all).to eq [@test_product1, @test_product2]
  end

  it "validates that name is present" do 
    should validate_presence_of(:name)
  end

  it "stores the cashier's login in lowercase" do
    expect(@test_product1.name).to eq "PAMPERS ULTRA"
  end
end
