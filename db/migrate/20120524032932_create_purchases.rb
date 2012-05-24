class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :item_id
      t.integer :supplier_id
      t.integer :price
      t.text :description
      t.integer :discount, :default => 0  # (percentage)
      
      t.datetime :discount_cut_off_date 
      t.boolean :has_early_delivery_discount, :default => false 
      
      
      t.integer :quantity_requested
      t.integer :purchase_requester_id 
      
      t.integer :quantity_ordered
      t.integer :purchase_order_creator_id 
      
      t.boolean :is_purchase_order_created, :default => false 
      
      
      t.integer :quantity_delivered , :default => 0 
      
      t.boolean :has_completed_delivery, :default => false
      
      t.datetime :expected_delivery_date
      t.datetime :actual_delivery_date
      
      t.boolean :is_multiple_delivery , :default => false 
      
      t.string :purchase_order_identification_number 
      t.integer :total_quantity_delivered , :default => 0
      
      # quantity delivered might be more than what is asked 
      # how will this impact the price? just take it as bonus 
      
      t.timestamps
    end
  end
end



