class Brand < ActiveRecord::Base
  attr_accessible :name, :member_discount, :stockist_discount 
  has_many :products 
end
