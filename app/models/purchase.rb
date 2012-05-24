class Purchase < ActiveRecord::Base
  # attr_accessible :title, :body
  
  has_one :item_batch
  
  has_many :incoming_deliveries, :as => :incoming_deliverable
  
  def pending_approval_purchase_requests
    # if it is the pasponsel.com, we take company params. :)
    PurchaseRequest.find(:all, :conditions => {
      :is_purchase_order_created => false  
    })
  end
  
  def ongoing_delivery_purchases
    PurchaseRequest.find(:all, :conditions => {
      :is_purchase_order_created => true,
      :has_completed_delivery => false   
    })
  end
  
  def finished_delivery_purchases
    PurchaseRequest.find(:all, :conditions => {
      :is_purchase_order_created => true,
      :has_completed_delivery => true   
    })
  end
end
