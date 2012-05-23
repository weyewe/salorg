require 'spec_helper'


describe Item do
  before(:each) do
    @sales_manager_role = FactoryGirl.create(:sales_manager_role)
    @product_creator_role = FactoryGirl.create(:product_creator_role)
    @customer_service_role = FactoryGirl.create(:customer_service_role)
    @warehouse_officer_role = FactoryGirl.create(:warehouse_officer_role)
    
    @sales_manager = User.create_user( [@sales_manager_role],
      'sales_manager@gmail.com',
      'willy1234',
      'willy1234'
    )
    @product_creator = User.create_user( [@product_creator_role], 
      'product_creator@gmail.com',
      'willy1234',
      'willy1234'
    )
    @customer_service = User.create_user( [@customer_service_role], 
      'customer_service@gmail.com',
      'willy1234',
      'willy1234' 

    )
    @warehouse_officer = User.create_user( [@warehouse_officer_role], 
      'warehouse_officer@gmail.com',
      'willy1234',
      'willy1234' 
    )
    
    @property_size = Property.create(:name => "Size" )
    @small_size_value  = @property_size.create_value(:name => "S", :description => "Small")
    @medium_size_value = @property_size.create_value(:name => "M", :description => "Medium ")
    @large_size_value  = @property_size.create_value(:name => "L", :description => "Large")
    
    
    @supplier = Supplier.create(:name => "Hamdani")
    @property_size_hash = {
      :property_id => @property_size.id,
      :value_id => @small_size_value.id 
    }
    
  end
  
  context "Pre condition, create base item on behalf of supplier" do
    before(:each) do 
   
    end
    
    
    it "should not allow user with no product_creator role to create the item" do
      item = Item.create_base_item_on_behalf_of_supplier(@warehouse_officer, @supplier, 
                                  {:name => "Azalea"}, 
                                  [ @property_size_hash ] )
                                  
      item.should be_nil  
      
      item = Item.create_base_item_on_behalf_of_supplier(@product_creator, @supplier, 
                                  {:name => "Azalea"}, 
                                  [@property_size_hash] )  
      item.should be_valid                         
    end
    
    it "should have supplier linked to the item" do
      item = Item.create_base_item_on_behalf_of_supplier(@product_creator, nil, 
                                  {:name => "Azalea"}, 
                                  [@property_size_hash] )
                                  
      item.should be_nil
      
      item = Item.create_base_item_on_behalf_of_supplier(@product_creator, @supplier, 
                                  {:name => "Azalea"}, 
                                  [@property_size_hash] )
                                  
      item.should be_valid
    end
     
    it "should have at least one property" do
      item = Item.create_base_item_on_behalf_of_supplier(@product_creator, @supplier, 
                                  {:name => "Azalea"}, 
                                  [ ] )
                                  
      item.should be_nil
      
      item = Item.create_base_item_on_behalf_of_supplier(@product_creator, @supplier, 
                                  {:name => "Azalea"}, 
                                  [ @property_size_hash] )
                                  
      item.should be_valid
    end
    
    context "Post conditions for create item on behalf of supplier" do
      before(:each) do
        @item = Item.create_base_item_on_behalf_of_supplier(@product_creator, @supplier, 
                                    {:name => "Azalea"}, 
                                    [ @property_size_hash] )
      end
      
      # it "sho"
    end
    
    
  end
  
  context "Pre condition, create variant item on behalf of supplier" do
    before(:each) do
      @base_item = Item.create_base_item_on_behalf_of_supplier(@product_creator, @supplier, 
                                  {:name => "Azalea"}, 
                                  [ @property_size_hash] )
    end
    
    it "should not allow duplicate property value in the item-variant_items group" do
      # @property_size_hash = {
      #   :property_id => @property_size.id,
      #   :value_id => @small_size_value.id 
      # }
      
      variant_item = base_item.create_variant_item( @product_creator, [@property_size_hash] )
      
      variant_item.should be_nil
    end
  end
  
end
