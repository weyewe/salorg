require 'spec_helper'

describe Variant do
  
  context "Post conditions on create" do 
    before(:each) do
      @base_item = Item.create :name => "Base Item"
      @variant_item_1 = Item.create :name => "Variant Item 2 "
      @base_item.variant_items << @variant_item_1
    end
    
    it "should add the variant item " do
      @base_item.should have(1).variant_items
    end
    
    it "should set the status of value item to be non-base item" do
      @variant_item_1.is_base_item.should be_false 
    end
    
    it "should respond to command base_item, returning the self if it is base item" do 
      @variant_item_1.base_item.id.should == @base_item.id 
    end
  end
  
  it 
end
