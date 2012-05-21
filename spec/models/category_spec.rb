require 'spec_helper'

describe Category do
  context "root category post creation"  do
    before(:each) do 
      @root_category_1 = Category.create_root_category(:title => "Male")
    end
    
    it "should create category with root category as true" do
      @root_category_1.is_root_category.should be_true 
    end
    
    it "should create absolute depth == 0, for root category" do
      @root_category_1.absolute_depth.should == ROOT_CATEGORY_ABSOLUTE_DEPTH
    end
    
  end
  
  context "sub_category post creation" do
    before(:each) do
      # create the root
      @root_category_1 = Category.create_root_category(:title => "Male")
      @sub_category_depth_1 = @root_category_1.create_sub_category(:title => "Top")
      @sub_category_depth_2 = @sub_category_depth_1.create_sub_category(:title => "T-Shirt")
    end
    
    it "should not return any other than itself, for root category direct parent" do
      @root_category_1.direct_parent_category.id.should == @root_category_1.id 
    end
    
    it "should produce depth level == x + 1 depth level, where x is the depth level of the direct parent" do
      @sub_category_depth_2.absolute_depth.should == @sub_category_depth_1.absolute_depth +  1
    end
    
    it "should produce direct edge from the parent's parents to itself" do
      CategoryEdge.find(:first, :conditions => {
        :category_id => @root_category_1.id ,
        :sub_category_id => @sub_category_depth_2.id 
      }).should be_valid 
    end
    
    it "should produce N new edges, where N is the total depth of the tree from the root" do
      CategoryEdge.find(:all, :conditions => {
        :sub_category_id => @sub_category_depth_2.id 
      }).count.should == 2 
    end
    
    
    
    
  end
end
