class Item < ActiveRecord::Base
  attr_accessible :name  , :category_id 
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
  
  #Category Ownership
  belongs_to :category 
  
  # Brand Ownership
  # belongs_to :brand 
    
  
  
  validates_presence_of :name 
  
  
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
  
  def self.valid_item_params_to_create_items_on_behalf_of_supplier( product_creator, property_value_list , supplier )
    if not product_creator.has_role?(:product_creator)
      return false
    end

    if not PropertyValue.valid_property_value_list?( property_value_list )
      return false
    end

    if supplier.nil?
      return false
    end

    return true
  end

  
  def self.create_base_item_on_behalf_of_supplier(product_creator, supplier, 
                              item_params, 
                              property_value_list )
   
    if not self.valid_item_params_to_create_items_on_behalf_of_supplier( product_creator, property_value_list , supplier )
      return nil
    end
    
    item = Item.create(:name => item_params[:name])
    
    item.supplier_id = supplier.id 
    # item.brand_id = brand.id 
    
    item.embed_property_value_list( property_value_list )
    
    return item 
  end
  
=begin
  Create VariantItem on behalf of supplier 
=end
  
  def has_similar_property_value_list?( property_value_list )
    property_value_list.each do |property_value_pair|
      if self.property_values.where(:property_id => property_value_pair[:property_id], 
                          :value_id => property_value_pair[:value_id]).count == 0 
          next
      else
        return true 
      end
    end
    
    return false 
    
  end
  
  def create_variant_item( product_creator, property_value_list )
    if self.has_similar_property_value_list?( property_value_list )
      return nil
    end
  end
  # 
  # def self.create_variant_item_on_behalf_of_supplier(product_creator, supplier, 
  #                             base_item, 
  #                             property_value_list )
  #  
  #   if not self.valid_item_params_to_create_items_on_behalf_of_supplier( product_creator, property_value_list , supplier )
  #     return nil
  #   end
  #   
  #   if self.has_similar_property_value_list_with_base_item( property_value_list )
  #     return nil
  #   end
  #   
  #   
  # 
  #   item = Item.create(:name => item_params[:name])
  # 
  #   item.supplier_id = supplier.id 
  #   # item.brand_id = brand.id 
  # 
  #   item.embed_property_value_list( property_value_list )
  # 
  #   return item 
  # end
  # 
end
