class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.string :name 
      t.text :address
      t.text :other_information
      t.string :phone_number 
      t.string :bbm_pin
    
      t.string :contact_person_name
      t.string :contact_person_phone_number
      t.string :contact_person_bbm_pin
      
      
      
      t.timestamps
    end
  end
end
