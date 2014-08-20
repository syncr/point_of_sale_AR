require 'spec_helper'

describe Sale do
  before do
    setup
  end

  it {should belong_to :customer}
  it {should belong_to :cashier}


  it 'will store a transaction in the DB' do
    @test_sale.save
    expect(Sale.all).to eq [@test_sale]
  end

  it 'will create a transaction instance with each method details available' do
    @test_product_sales.save
    expect(@test_sale.customer_id).to eq 1
    expect(@test_sale.cashier_id).to eq 1
    expect(@test_sale.product_id).to eq 1
    expect(@test_sale.product_quantity).to eq 1
  end
end
