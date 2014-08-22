class Product < ActiveRecord::Base
  has_many :purchases
  has_many :sales, through: :purchases

  def most_popular
    Record.count('name', :distinct => true)
  end

end
