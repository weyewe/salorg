class ItemBatch < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :item_batch
  
  has_one :purchase
  
  # has_many :inbound_documents
  
end
