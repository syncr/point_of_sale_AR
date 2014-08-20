class ChangeColumnNameProductSalesSalesId < ActiveRecord::Migration
  def change
    rename_column(:product_sales, :sales_id, :sale_id)
  end
end
