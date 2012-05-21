class Value < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :property 
  
  has_many :items, :through => :property_values 
  has_many :property_values
  
end
