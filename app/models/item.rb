class Item < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :variants
  has_many :variant_items, :through => :variants, 
    :source => :variant_item 
    
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
