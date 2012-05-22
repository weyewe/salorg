class Item < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :supplier 
  has_many :item_batches # item is bought batch by batch, with different price
  # this is the method to calculate price 
  
  
  has_many :variants
  has_many :variant_items, :through => :variants, 
    :source => :variant_item 
  
  
  # Variant Creator 
  has_many :property_values 
  has_many :properties, :through => :property_values
  has_many :values, :through => :property_values
  
  # Product creator
  has_many :product_memberships
  has_many :products, :through => :product_memberships 
  
  
  # Brand Ownership
  belongs_to :brand 
    
  attr_accessible :name  
  
  
=begin
  For the self many-many referential 
=end
  def base_item
    if self.is_base_item == true
       return self
    elsif self.is_base_item == false
      return Item.find_by_id self.base_item_id
    end
  end
  
  
=begin
  Create item on behalf of supplier
=end

  def embed_property_value_list( property_value_list )
    count =  1 
    property_value_list.each do |property_value_pair|
      PropertyValue.create(:item_id => self.id, 
        :property_id => property_value_pair[:property_id],
        :value_id => property_value_pair[:value_id],
        :position => count)
      count += 1 
    end
    
  end
  
  def self.create_item_on_behalf_of_supplier(product_creator, supplier, 
                              item_params, 
                              brand, property_value_list, price )
    if not product_creator.has_role?(:product_creator)
      return nil
    end
    
    if not PropertyValue.valid_property_value_list?( property_value_list )
      return nil
    end
    
    item = Item.create(:name => item_params[:name])
    
    item.supplier_id = supplier.id 
    item.brand_id = brand.id 
    
    item.embed_property_value_list( property_value_list )
    
    return item 
  end
  
  
end
