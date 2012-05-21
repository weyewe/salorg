class CreateVariants < ActiveRecord::Migration
  def change
    create_table :variants do |t|
      
      t.integer :item_id
      t.integer :variant_item_id

      t.timestamps
    end
  end
end
