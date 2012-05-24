class StockMigration < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :incoming_deliveries, :as => :incoming_deliverable
  belongs_to :item
end
