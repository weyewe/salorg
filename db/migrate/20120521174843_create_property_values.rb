class CreatePropertyValues < ActiveRecord::Migration
  def change
    create_table :property_values do |t|
      t.integer :property_id 
      t.integer :value_id 
      
      t.integer :item_id 
      
      t.timestamps
    end
  end
end
