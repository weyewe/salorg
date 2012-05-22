class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :supplier_id 
      t.string :name
      
      # item has_many :variant_items
      # variant_item belongs_to :base_item
      t.integer :base_item_id 
      t.boolean :is_base_item , :default => true 
      
      t.integer :category_id 
      
      
      # t.decimal :base_price , :precision => 9, :scale => 2 , :default => 0  # highest price is 7 digit
              # 9,999,999 
      # not like this. inventory pricing. 
      # the first batch (100 items) == 50,000
      # the second batch( 200 items) == 30,000. 
      # FIFO: first in , first out.
      # for the first 100 items, use the 50,000 rupiah. 
      # how can we model this? 
      
      
      t.timestamps
    end
  end
end
