class Product < ActiveRecord::Base
  attr_accessible :price
  has_many :items, :through => :product_memberships
  has_many :product_memberships
  
  
  def self.direct_promote_item_to_product_on_behalf_of_supplier(product_creator, supplier, 
                              item_params, 
                              brand, property_value_list, price )
    if price  < 0 
      return nil
    end
    
    item =  Item.create_item_on_behalf_of_supplier(product_creator, supplier, 
                                item_params, 
                                brand, property_value_list, price )
    
    if not item.nil?
      product = Product.create :price => price 
      product.items << item 
      return product
    else
      return nil
    end
  end

end
