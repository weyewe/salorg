class CreateValues < ActiveRecord::Migration
  def change
    create_table :values do |t|
      t.string :name
      t.integer :property_id 

      t.timestamps
    end
  end
end
