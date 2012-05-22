class Property < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :values 
  
  has_many :items, :through => :property_values 
  has_many :property_values 
  
  attr_accessible :name 
  
  
  def create_value(params)
    Value.create :property_id => self.id, :name => params[:name]
  end
  
  def has_value?(value)
    self.values.where(:value_id => value.id ).count == 1 
  end
end
