class ProductMembership < ActiveRecord::Base
  attr_accessible :item_id, :product_id
  belongs_to :item
  belongs_to :product
end
