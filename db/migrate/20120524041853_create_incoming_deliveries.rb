class CreateIncomingDeliveries < ActiveRecord::Migration
  def change
    create_table :incoming_deliveries do |t|
      t.integer :quantity 
      

      t.integer :incoming_deliverable_id
      t.string :incoming_deliverable_type
      t.timestamps
    end
  end
end
