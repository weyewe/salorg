class Product < ActiveRecord::Base
  attr_accessible :price, :brand_id, :product_creator_id 
  has_many :items, :through => :product_memberships
  has_many :product_memberships
  
  # Brand Ownership
  belongs_to :brand 
  
  has_many :price_histories
  
  after_create :add_initial_price_history
                              
                              
  def self.direct_promote_base_item_to_product_on_behalf_of_supplier(product_creator, supplier, 
                              item_params, 
                              brand, property_value_list, price )
    if price  < BigDecimal("0")
      return nil
    end
    
    if not product_creator.has_role?(:product_creator)
      return nil
    end
    
    item =  Item.create_base_item_on_behalf_of_supplier(product_creator, supplier, 
                                item_params, 
                                property_value_list )
    
    if not item.nil?
      product = Product.create :price => price , :product_creator_id => product_creator.id 
      product.items << item 
      return product
    else
      return nil
    end
  end
  
  def product_creator
    User.find_by_id self.product_creator_id 
  end
  
  def change_price(new_price, price_changer)
    if new_price < BigDecimal("0") or not price_changer.has_role?(:product_creator)
      return nil
    else
      self.price = new_price
      price_history = PriceHistory.add_price_history( price_changer, self.price, self)
      return price_history
    end
  end
  
  
  
  
  def add_initial_price_history
    # the first price created
    PriceHistory.add_price_history( self.product_creator , self.price, self)
  end
  
  
end
