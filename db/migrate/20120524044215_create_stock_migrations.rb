class CreateStockMigrations < ActiveRecord::Migration
  def change
    create_table :stock_migrations do |t|
      t.integer :quantity
      t.integer :item_id 

      t.integer :migrator_id 
      t.timestamps
    end
  end
end
