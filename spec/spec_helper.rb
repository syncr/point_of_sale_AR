require 'pg'
require 'active_record'
require 'rspec'
require 'shoulda-matchers'
require 'pry'

require 'cashier'
require 'customer'
require 'product'
require 'purchase'
require 'sale'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["test"])

RSpec.configure do |config|
  config.after(:each) do
    Customer.all.each { |customer| customer.destroy }
    Cashier.all.each { |cashier| cashier.destroy }
    Product.all.each { |product| product.destroy }
    Sale.all.each { |sale| sale.destroy }
    Purchase.all.each {|product_sale| product_sale.destroy}
  end
end

def setup
    @test_product1 = Product.create({:name => "Pampers Ultra", :cost => 29.99})
    @test_product2 = Product.create({:name => "Goobers", :cost => 1.99})
    @test_customer = Customer.create({:name => "Jack Customer"})
    @test_cashier  = Cashier.create({:name => "Jill Cashier"})
    @test_sale  = Sale.create({:product_quantity => 1, :cashier_id => @test_cashier.id, :customer_id => @test_customer.id})
    @test_purchase1 = Purchase.create({:product_id => @test_product1.id, :sale_id => @test_sale.id})
    @test_purchase2 = Purchase.create({:product_id => @test_product2.id, :sale_id => @test_sale.id})
end
