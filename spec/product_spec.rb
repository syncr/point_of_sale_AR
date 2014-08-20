require "spec_helper"

describe Product do
  before do
    setup
  end


  it "will store products in the DB" do
    expect(Product.all).to eq [@test_product1, @test_product2]
  end
end
