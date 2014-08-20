class RemoveProductIdFromSales < ActiveRecord::Migration
  def change
        remove_column(:sales, :product_id)

  end
end
