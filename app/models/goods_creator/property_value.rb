class PropertyValue < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :item
  
  
  belongs_to :property 
  belongs_to :value 
end
