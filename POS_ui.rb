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
      puts "What is the category of #{product_name}?"
      category = gets.chomp
      add_product(product_name, product_price, category)
      puts "Ok, you've added #{product_name} for $#{product_price}"
      sleep(3)
    when "2"
      puts "What is the name of the new cashier?"
      cashier_name = gets.chomp
      puts "What will be #{cashier_name}'s' login name?"
      cashier_login = gets.chomp
      add_cashier(cashier_name, cashier_login)
      puts "Ok, you've added #{cashier_name} for #{cashier_login}"
      sleep(3)
    when "3"
      puts "Enter the starting date in the following format (YYYY/MM/DD)?"
      date_start = gets.chomp
      puts "Enter the ending date in the following format (YYYY/MM/DD)?"
      date_end = gets.chomp
      result = Purchase.total_sold(date_start, date_end)
      puts "The total sold from #{date_start} to #{date_end} was $#{result}"
      sleep(3)
    when "4"
      puts "Enter the cashier's name..."
      cashier_name = gets.chomp
      result = Cashier.total_sold_by(cashier_name)
      puts "The total sold by #{cashier_name} to was $#{result}"
      sleep(3)
    when "5"
      puts "Enter the cashier's name..."
      cashier_name = gets.chomp
      result = Product.list_most_popular
      puts "The the most popular item is #{result}"
      sleep(3)
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

  # product_list = Product.all
  # product_list.each do |product|

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
    this_purchase.sale.purchases.each do |purchase|
      item_name = purchase.product.name
      item_cost = purchase.product.cost
      item_quantity = purchase.product_quantity

      puts "Product: #{item_name} \t Cost: #{item_cost} \t Quantity:#{item_quantity}"
      total_cost += item_cost.to_f * item_quantity.to_f
    end
    puts "----------------Total Cost: $#{total_cost}----------------"
    puts "\n\nHit enter to return to the Cashier Menu"
    gets.chomp
    cashier
  end
end

def add_product(product_name, product_price, category)
  add_product = Product.create({:name => "#{product_name}", :cost => "#{product_price}", :category => "#{product_price}"})
end

def add_cashier(cashier_name, cashier_login)
  add_cashier = Cashier.create({:name => "#{cashier_name}", :login => "#{cashier_login}"})
end
main_menu
