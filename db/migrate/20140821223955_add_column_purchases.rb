class AddColumnPurchases < ActiveRecord::Migration
  def change
    add_column(:purchases, :product_quantity, :int)
  end
end
