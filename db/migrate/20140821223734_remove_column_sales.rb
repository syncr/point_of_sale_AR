class RemoveColumnSales < ActiveRecord::Migration
  def change
    remove_column(:sales, :product_quantity)
  end
end
