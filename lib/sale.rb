class Sale < ActiveRecord::Base
  has_many :product_sales
  belongs_to :cashier
  belongs_to :customer
end
