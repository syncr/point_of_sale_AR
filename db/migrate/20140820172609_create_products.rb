class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.column :name, :string
      t.column :cost, :float
      t.timestamps
    end
  end
end
