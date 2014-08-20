class AddTimestampProductSales < ActiveRecord::Migration
  def change
      add_column(:product_sales, :created_at, :datetime)
      add_column(:product_sales, :updated_at, :datetime)
  end
end
