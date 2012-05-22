class ItemBatch < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :item 
  
end
