class CreatePriceHistories < ActiveRecord::Migration
  def change
    create_table :price_histories do |t|
      t.decimal :price , :precision => 9, :scale => 2 , :default => 0 
      t.integer :product_id 
      t.integer :price_changer_id 
      
      t.timestamps
    end
  end
end
