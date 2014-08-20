class Product_Sales < ActiveRecord::Base
  has_many :products
  belongs_to :sale
end
