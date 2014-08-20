class RenameTableProductSalesToPurchase < ActiveRecord::Migration
  def change
    rename_table :product_sales, :purchases
  end
end
