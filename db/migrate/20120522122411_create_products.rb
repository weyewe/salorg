class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.decimal :price , :precision => 9, :scale => 2 , :default => 0 
      # max is 9,999,999 rupiah
      t.integer :product_type , :default => PRODUCT_TYPE[:single_item]
      t.integer :brand_id 
      
      t.integer :product_creator_id 
      
      
      t.timestamps
    end
  end
end
