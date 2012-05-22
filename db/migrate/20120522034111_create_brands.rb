class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :name
      t.text :description 
      
      t.integer :member_discount
      t.integer :stockist_discount 
      
      t.timestamps
    end
  end
end
