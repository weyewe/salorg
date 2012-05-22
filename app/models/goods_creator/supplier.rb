class Supplier < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :items 
  
  
=begin
  Self propose new item
=end

  def create_item( name, description, base_price )
    
  end
end
