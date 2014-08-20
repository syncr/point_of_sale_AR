class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
    t.column :product_id, :int
    t.column :product_quantity, :int
    t.column :cashier_id, :int
    t.column :customer_id, :int
    t.timestamps
    end
  end
end
