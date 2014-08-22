class Purchase < ActiveRecord::Base
  belongs_to :product
  belongs_to :sale


  def self.total_sold(date_start, date_end)
    #for Purchase.all(date_range), get each Product.cost iteratively add to sum total
    total_sold = 0
    purchase_window = Purchase.where(:created_at => date_start..date_end)
    purchase_window.each do |item|
      item_id = item.product_id
      item_cost = Product.where(id: item_id).first.cost
      total_sold += item_cost.to_f
    end
    total_sold.round(2)
  end

  def most_popular

  # when purchase contains product
  #   Purchase.distinct.count('name')
  end
end
