class Property < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :values 
  
  has_many :items, :through => :property_values 
  has_many :property_values 
end
