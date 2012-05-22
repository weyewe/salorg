require 'spec_helper'

describe User do
  before(:each) do 
    @sales_manager_role = FactoryGirl.create(:sales_manager_role)
    @product_creator_role = FactoryGirl.create(:product_creator_role)
    @customer_service_role = FactoryGirl.create(:customer_service_role)
    @warehouse_officer_role = FactoryGirl.create(:warehouse_officer_role)
  end
  
  context "User creation" do
    it "should not allow duplicate email" do
      sales_manager = User.create_user([@sales_manager_role], 'sm@gmail.com', 'willy1234', 'willy1234')
      sales_manager.should be_valid
      
      sales_manager_2 = User.create_user([@sales_manager_role], 'sm@gmail.com', 'willy1234', 'willy1234')
      sales_manager_2.should be_nil
    end
    
    it "should not allow double roles" do
      
      sales_manager = User.create_user([@sales_manager_role,@sales_manager_role ], 'sm@gmail.com', 'willy1234', 'willy1234')
      sales_manager.should have(1).roles
    end
  end
end
