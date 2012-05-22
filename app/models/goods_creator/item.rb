class Item < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :supplier 
  has_many :item_batches # item is bought batch by batch, with different price
  # this is the method to calculate price 
  
  
  has_many :variants
  has_many :variant_items, :through => :variants, 
    :source => :variant_item 
  
  
  # Variant Creator 
  has_many :property_values 
  has_many :properties, :through => :property_values
  has_many :values, :through => :property_values
  
  
  # Brand Ownership
  belongs_to :brand 
    
  attr_accessible :name  
  
  
=begin
  For the self many-many referential 
=end
  def base_item
    if self.is_base_item == true
       return self
    elsif self.is_base_item == false
      return Item.find_by_id self.base_item_id
    end
  end
  
  
  
  
end
