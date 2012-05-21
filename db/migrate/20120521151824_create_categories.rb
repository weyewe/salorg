class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      
      t.string :title 
      t.text :description 
      
      # root category is the first level category. the root. 
      # the absolute depth is 0.
      # the first sub_category of this root_category is category with absolute depth == 1 
      t.boolean :is_root_category, :default => false 
      t.integer :direct_parent_category_id 
      t.integer :absolute_depth, :null => false 
      
      
      t.timestamps
    end
  end
end
