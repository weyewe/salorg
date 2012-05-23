class Product < ActiveRecord::Base
  attr_accessible :price, :brand_id, :product_creator_id 
  has_many :items, :through => :product_memberships
  has_many :product_memberships
  
  # Brand Ownership
  belongs_to :brand 
  
  has_many :price_histories
  
  after_create :add_initial_price_history
  
  
=begin
  Product Creation (direct promote from item, on behalf of supplier)
=end
  def self.valid_direct_promote_item_to_product_parameters?(price, product_creator) 
    if price  < BigDecimal("0")
      return false
    end
    
    if not product_creator.has_role?(:product_creator)
      return false
    end
    
    return true 
  end
  
  
                        
  def self.direct_promote_base_item_to_product_on_behalf_of_supplier(product_creator, supplier, 
                              item_params, 
                              brand, property_value_list, price )
    
    if not Product.valid_direct_promote_item_to_product_parameters?(price, product_creator) 
      return nil
    end
    
    item =  Item.create_base_item_on_behalf_of_supplier(product_creator, supplier, 
                                item_params, 
                                property_value_list )
    
    if not item.nil?
      # product = Product.create :price => price , :product_creator_id => product_creator.id 
      #       product.items << item 
      #       product.brand_id = brand.id 
      #       return product
      Product.create_from_item( price, product_creator, item, brand ) 
    else
      return nil
    end
  end
  
  def Product.direct_promote_variant_item_to_product_on_behalf_of_supplier(product_creator,supplier, 
                              base_item,  # name is taken from the base item 
                              brand, property_value_list, price )
    if  not Product.valid_direct_promote_item_to_product_parameters?(price, product_creator)
      return nil
    end
    
    
    variant_item = base_item.create_variant_item(product_creator, property_value_list )
    
    if not item.nil?
      Product.create_from_item( price, product_creator, variant_item, brand ) 
      # product = Product.create :price => price, :product_creator_id => product_creator.id
      # product.items << item 
      # product.brand_id = brand.id 
      # return product 
    else
      return nil
    end
    
  end
  
  
  def Product.create_from_item( price, product_creator, item, brand ) 
    product = Product.create :price => price, :product_creator_id => product_creator.id
    product.items << item 
    product.brand_id = brand.id
    product.save
    return product 
  end
  
=begin
  Utility methods for product 
=end
  def product_creator
    User.find_by_id self.product_creator_id 
  end
  
  
=begin
  Tracking price change 
=end
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
