class CreatePropertyValues < ActiveRecord::Migration
  def change
    create_table :property_values do |t|
      t.integer :property_id 
      t.integer :value_id 
      
      t.integer :item_id 
      
      t.integer :position
      
      t.timestamps
    end
  end
end
