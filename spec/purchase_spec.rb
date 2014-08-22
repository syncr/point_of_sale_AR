require "spec_helper"

describe Purchase do
  before do
    setup
  end

  it {should belong_to :product}
  it {should belong_to :sale}

  it "will contain multiple products" do
    expect(@test_sale.products).to eq [@test_product1, @test_product2]
  end

  it "will tally the told products sold via the POS" do
    expect(Purchase.total_sold('2010-01-1', '2015-01-1')).to eq (31.98)
  end



end
