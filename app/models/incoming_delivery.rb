class IncomingDelivery < ActiveRecord::Base
  # attr_accessible :title, :body
  # purchase_order has incoming delivery
  # return notice has incoming delivery 
    # which price? price when it was bought. In sales order, list the batch id
    # sales order entry
  # reject supplier has incoming delivery 
  
  # good candidate for polymorphism 
  
  belongs_to :incoming_deliverable, :polymorphic => true 
end
