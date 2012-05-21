class CategoryEdge < ActiveRecord::Base
  
  belongs_to :category
  belongs_to :sub_category, :class_name => "Category"
  
  # after_create :propagate_edge_creation_to_the_root
  # before_destroy :propagate_edge_deletion_to_the_root 
  
  
  attr_accessible :category_id, :sub_category_id, :delta
  
  
  
  
 
  
end
