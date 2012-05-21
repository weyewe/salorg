class Variant < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :item
  belongs_to :variant_item, :class_name => "Item"
  
  after_create :assign_item_variation_status
  
  
  
  protected 
  
  def assign_item_variation_status
    variant_item = self.variant_item 
    variant_item.is_base_item = false 
    variant_item.base_item_id = self.item_id
    
    variant_item.save 
  end
end
