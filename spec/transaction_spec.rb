require 'spec_helper'

describe Transaction do
  before do
    setup
  end

  it 'will store a transaction in the DB' do
    @test_transaction.save
    expect(Transaction.all).to eq [@test_transaction]


  end
end
