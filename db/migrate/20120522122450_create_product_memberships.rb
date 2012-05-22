class CreateProductMemberships < ActiveRecord::Migration
  def change
    create_table :product_memberships do |t|
      t.integer :item_id
      t.integer :product_id 
      

      t.timestamps
    end
  end
end
