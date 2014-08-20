require 'pg'
require 'active_record'
require 'rspec'
require 'shoulda-matchers'

require 'cashier'
require 'customer'
require 'product'
require 'product_sales'
require 'sale'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["test"])

RSpec.configure do |config|
  config.after(:each) do
    Customer.all.each { |customer| customer.destroy }
    Cashier.all.each { |cashier| cashier.destroy }
    Product.all.each { |product| product.destroy }
    Sale.all.each { |sale| sale.destroy }
    Product_Sales.all.each {|product_sale| product_sale.destroy}
  end
end

def setup
  @test_customer = Customer.new({:name => "Jack Customer"})
  @test_cashier = Cashier.new({:name => "Jill Cashier"})
  @test_sale = Sale.new({:product_id => 1, :product_quantity => 1, :cashier_id => 1, :customer_id => 1})
  @test_product = Product.new({:name => "Pampers Ultra", :cost => 29.99})
  @test_product_sales = Product_Sales.new({:product_id => @test_product.id, :sale_id => @test_sale.id})
end
