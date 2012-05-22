class Brand < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :items 
end
