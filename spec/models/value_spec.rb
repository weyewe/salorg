require 'spec_helper'

describe Value do
  context "create value from property" do
    before(:each) do
      @size_property = Property.create :name => "Size"
    end
    
    it "should be created from property, linked to the creating property" do
      small_value = @size_property.create_value(:name => "S")
      medium_value = @size_property.create_value(:name => "M")
      large_value = @size_property.create_value(:name => "L")
      
      @size_property.should have(3).values
      small_value.property.should == @size_property
    end
  end
end
