require "spec_helper"

describe Product do
  before do
    setup
  end

  it {should belong_to :sale}

  it "will store a product in the DB" do
    @test_product.save
    expect(Product.all).to eq [@test_product]
  end
end
