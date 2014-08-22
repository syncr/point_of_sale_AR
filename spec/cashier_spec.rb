require 'spec_helper'

describe Cashier do
  before do
    setup
  end

  it {should have_many :sales}
  it {should have_many(:customers).through(:sales)}


  it 'will store a cashier in the DB' do
    @test_cashier.save
    expect(Cashier.all).to eq [@test_cashier]
  end
end
