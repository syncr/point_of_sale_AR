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

  it 'will create a transaction instance with each transaction details available' do
    @test_sale.save
    expect(@test_customer.name).to eq 'Jack Customer'
    expect(@test_cashier.name).to eq 'Jill Cashier'
    expect(@test_product1.name).to eq "Pampers Ultra"
    expect(@test_sale.product_quantity).to eq 1
  end
end
