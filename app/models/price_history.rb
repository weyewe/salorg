class PriceHistory < ActiveRecord::Base
  attr_accessible :product_id
 
  belongs_to :product
  
  def self.add_price_history( user , price, product)
    price_history = PriceHistory.create :product_id =>  product.id 
    price_history.price_changer_id = user.id
    price_history.price = price 
    price_history.save
  end
end
