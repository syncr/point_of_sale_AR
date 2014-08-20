class AddColumnToSaleTable < ActiveRecord::Migration
  def change
    add_column :products, :sale_id, :int
  end
end
