require 'active_record'
require './lib/cashier.rb'
require './lib/customer.rb'
require './lib/product.rb'
require './lib/purchase.rb'
require './lib/sale.rb'
require 'pry'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["development"])

def main_menu
  system 'clear'
  puts "Welcome to the SuperMart POS. Please select an option"
  puts "\t1 -- Manager Functions"
  puts "\t2 -- Cashier Functions"
  puts "\t3 -- Customer Functions"

  choice = gets.chomp
  case choice
    when "1"
      manager
    when "2"
      cashier
    when "3"
      customer
  end
end

def manager
  system 'clear'
  puts "----------Manager Functions----------"
  puts "\nSelect a Function below:"
  puts "\t1 -- Add Product "
  puts "\t2 -- Create Login"
  puts "\t3 -- Total sold in Date Range  "
  puts "\t4 -- Total sold by Cashier "
  puts "\t5 -- Return to main menu"

  choice = gets.chomp

  case choice
    when "1"
      puts "What is the name of the new product?"
      product_name = gets.chomp
      puts "What is the price of #{product_name}?"
      product_price = gets.chomp
      add_product(product_name, product_price)
      puts "Ok, you've added #{product_name} for $#{product_price}"
      sleep(2)
    when "2"
      puts "What is the name of the new cashier?"
      cashier_name = gets.chomp
      puts "What will be #{cashier_name}'s' login name?"
      cashier_login = gets.chomp
      add_cashier(cashier_name, cashier_login)
      puts "Ok, you've added #{cashier_name} for #{cashier_login}"
    when "3"
      method
    when "4"
      method
    when "5"
      main_menu
  end
  manager
end

def cashier
  system 'clear'
  puts "----------Cashier Functions----------"
  print "\nPlease Login: "
  login = gets.chomp
  @this_cashier = Cashier.find_by login: "#{login}"
  if @this_cashier != nil
    puts "Welcome #{@this_cashier.name}"
    puts "Hit enter to start a new customer transaction:"
    gets.chomp
  else
    puts "Sorry you are unauthorized to use this system"
    exit
  end
  puts "What is the name of your customer:"
  customer = gets.chomp
  @this_customer = Customer.create(:name => "#{customer}")
  @this_sale = Sale.create(:cashier_id => "#{@this_cashier.id}", :customer_id => "#{@this_customer.id}")
  puts "Here are the items in the store:"
  Product.find_each do |product|
    puts "#{product.id}) #{product.name} === #{product.cost}"
  end
  enter_items
end

def enter_items
  p "Enter the item's # to input:"
  item_id = gets.chomp

  result = Product.find_by id: "#{item_id}"
  if result != nil
    puts "How many #{result.name} ?"
    item_quantity = gets.chomp
    this_purchase = Purchase.create(:product_id => "#{result.id}", :sale_id => "#{@this_sale.id}", :product_quantity => "#{item_quantity}")
  else
    puts "Sorry, we don't have that item."
    puts "Please look at the list and try again."
  end
  puts "Press 'C' to continue adding items or 'F' when finished"
  menu_option = gets.chomp.downcase
  case menu_option
  when "c"
    enter_items
  when "f"
    puts "Your receipt is as follows:"
    total_cost = 0.00
    Purchase.where(sale_id: "#{this_purchase.sale_id}").find_each do |i|
      item_id = i.product_id
      item_name = Product.where(id: item_id).first.name
      item_cost = Product.where(id: item_id).first.cost
      item_quantity = Purchase.where(id: item_id).first.product_quantity

      puts "Product: #{item_name} \t Cost: #{item_cost} \t Quantity:#{item_quantity}"
      total_cost += item_cost.to_f * item_quantity.to_f
    end
    puts "----------------Total Cost: $#{total_cost}----------------"
    puts "\n\nHit enter to return to the Cashier Menu"
    gets.chomp
    cashier
  end
end

def customer

  choice = gets.chomp
end

def add_product(product_name, product_price)
  add_product = Product.create({:name => "#{product_name}", :cost => "#{product_price}"})
end

def add_cashier(cashier_name, cashier_login)
  add_cashier = Cashier.create({:name => "#{cashier_name}", :login => "#{cashier_login}"})
end

main_menu

# 3) Cashier selects product name from list and then the quantity, stores it in the transaction, at the end returns all products, their prices, and the transaction total to the customer (receipt)
# 4) Manager >> Method(Sale): total_amount_sold(date_range)
# 5) Manager >> Method(Sale): total_transactions(cashier_name)
# 6) Customer >> return_products_from_previous_transaction(products)
# 7) Method(Product): most_popular_item
#   > return ordered list of quantity sold
# 8) Method(Product): least_popular_item
#   > return ordered list of quantity returned


