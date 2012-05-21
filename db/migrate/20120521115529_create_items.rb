class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :supplier_id 
      t.string :name
      
      # item has_many :variant_items
      # variant_item belongs_to :base_item
      t.integer :base_item_id 
      t.boolean :is_base_item , :default => true 
      
      
      t.timestamps
    end
  end
end
