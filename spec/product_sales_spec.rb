require "spec_helper"

describe Purchase do
  before do
    setup
  end

  it {should belong_to :sale}

  it "will contain multiple products" do
    expect(@test_sale.products).to eq [@test_product1, @test_product2]
  end
end
