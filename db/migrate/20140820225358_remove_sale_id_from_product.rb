class RemoveSaleIdFromProduct < ActiveRecord::Migration
  def change
    remove_column(:products, :sale_id)
  end
end
