require "spec_helper"

describe Product_Sales do
  before do
    setup
  end

  it {should belong_to :sale}

  it "will store a product_sale in the DB" do
    @test_product_sales.save
    expect(Product_Sales.all).to eq [@test_product_sales]
  end
end
