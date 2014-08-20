class CreateProductSales < ActiveRecord::Migration
  def change
    create_table :product_sales do |t|
      t.column :sales_id, :int
      t.column :product_id, :int
    end
  end
end
