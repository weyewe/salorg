class CreateItemBatches < ActiveRecord::Migration
  def change
    create_table :item_batches do |t|
      t.decimal :item_price , :precision => 9, :scale => 2 , :default => 0  # highest price is 7 digit
              # 9,999,999
      t.integer :quantity_purchased
      t.integer :quantity_received 
      t.integer :quantity_sold
      t.boolean :is_finished, :default => false 
      
      t.integer :item_id 
      
      # linked 
      t.integer :purchase_id 

      t.timestamps
    end
  end
end
