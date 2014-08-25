class Cashier < ActiveRecord::Base
  has_many :sales
  has_many :customers, through: :sales
  validates :name, presence: true

  def self.total_sold_by(cashier_name)
    total_sold_by = 0
    cashier = Cashier.where(:name => cashier_name).first
    cashier.sales.each do |sale|
      sale.purchases.each do |purchase|
        item_id = purchase.product_id
        item_cost = Product.where(id: item_id).first.cost
        total_sold_by += item_cost.to_f * purchase.product_quantity
      end
    end
    total_sold_by.round(2)
  end
end

