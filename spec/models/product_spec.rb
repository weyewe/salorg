require 'spec_helper'

describe Product do
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
    
    @second_skin = Brand.create :name => "Second SKin"
    
    
  end
  
  
  context "Pre condition, create base product on behalf of supplier, auto promote from item" do
    it "should not allow user with no product_creator role to create the item" do
      product = Product.direct_promote_base_item_to_product_on_behalf_of_supplier(@product_creator, @supplier, 
                                  {:name => "Azalea"}, 
                                  @second_skin, [@property_size_hash], BigDecimal("-5000") )
                                  
      product.should be_nil     
      
    end
  end
  
  context "Post condition, create base product on behalf of supplier, auto promote from item" do
    it "should create the related product memberships and items" do
      product = Product.direct_promote_base_item_to_product_on_behalf_of_supplier(@product_creator, @supplier, 
                                  {:name => "Azalea"}, 
                                  @second_skin, [@property_size_hash], BigDecimal("500000") )
                                  
      product.should be_valid     
      
      product.should have(1).items
      product.should have(1).product_memberships 
      product.should have(1).price_histories
    end
  end
  
  context "Changing Price" do
    before(:each) do 
      @product = Product.direct_promote_base_item_to_product_on_behalf_of_supplier(@product_creator, @supplier, 
                                  {:name => "Azalea"}, 
                                  @second_skin, [@property_size_hash], BigDecimal("500000") )
    end
    
    it "should not allow negative price" do
      result = @product.change_price(BigDecimal("-50") , @product_creator)
      result.should be_nil 
    end
    
    it "should only be changed by prodct creator" do
      result = @product.change_price(BigDecimal("50") , @warehouse_officer)
      result.should be_nil
    end
    
    it "should change the price, and add new price history" do
      initial_price_history_count = @product.price_histories.count 
      new_price = BigDecimal("100000")
      new_price_history = @product.change_price( new_price , @product_creator)
      
      new_price_history.should be_valid 
      
      final_price_history_count = @product.price_histories.count 
      
      (final_price_history_count - initial_price_history_count).should == 1 
      @product.price.should == new_price 
    end
    
  end
end
