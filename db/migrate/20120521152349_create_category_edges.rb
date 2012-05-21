class CreateCategoryEdges < ActiveRecord::Migration
  def change
    create_table :category_edges do |t|
      t.integer :category_id 
      t.integer :sub_category_id 
      
      t.integer :delta
      # delta: absolute depth of the sub_category
      #   minus absolute depth of the parent category

      t.timestamps
    end
  end
end
