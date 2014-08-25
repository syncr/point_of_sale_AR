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

  it "stores the product's name in uppercase" do
    expect(@test_product1.name).to eq "PAMPERS ULTRA"
  end

  it "will provide a cashier with all products in a category" do
    expect(Product.find_category("Bathroom").first).to eq @test_product1
  end

  it "will return the most popular product based on sales" do
    expect(Product.list_most_popular).to eq "PAMPERS ULTRA"
  end
end
