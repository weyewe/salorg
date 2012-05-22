class PropertyValue < ActiveRecord::Base
  attr_accessible :item_id, :property_id, :value_id, :position 
  belongs_to :item
  
  
  belongs_to :property 
  belongs_to :value 
  
  
  
  
  
  def PropertyValue.valid_property_value_list?( property_value_list )
    property_value_list.each do |property_value_pair|
      property = Property.find_by_id property_value_pair[:property_id]
      value = Value.find_by_id property_value_pair[:value_id]
      if property.has_value?(value)
        next
      else
        return false
      end
    end
    
    return true 
  end
  
end
