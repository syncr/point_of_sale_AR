require 'pg'
require 'active_record'
require 'rspec'

require 'cashier'
require 'customer'
require 'product'
require 'transaction'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["test"])

RSpec.configure do |config|
  config.after(:each) do
    Customer.all.each { |customer| customer.destroy }
    Cashier.all.each { |cashier| cashier.destroy }
    Product.all.each { |product| product.destroy }
    Transaction.all.each { |transaction| transaction.destroy }
  end
end

def setup
  @test_customer = Customer.new({:name => "Joe Customer"})
end
