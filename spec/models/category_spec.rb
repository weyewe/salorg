require 'spec_helper'

describe Category do
  context "root category creation"  do
    before(:each) do 
      @root_category_1 = Category.create_root_category(:title => "Male")
    end
    
    it "should create category with root category as true" do
      @root_category_1.is_root_category.should be_true 
    end
    
    it "should create absolute depth == 0, for root category" do
      @root_category_1.absolute_depth.should == ROOT_CATEGORY_ABSOLUTE_DEPTH
    end
    
    it "should return itself, if it receives direct_parent_category message" do
      @root_category_1.direct_parent_category.id.should == @root_category_1.id 
    end
  end
  
  context "sub_category creation" do
    before(:each) do
      # create the root
      @root_category_1 = Category.create_root_category(:title => "Male")
    end
    
    
    context "sub-category of a sub category"  do
      it "should produce N new edges, where N is the total depth of the tree from the root" do
      end
    end 
    
    
    
    
  end
end
