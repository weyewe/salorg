base_item = Item.create :name => "Base Item"
variant_item_1 = Item.create :name => "Variant Item 1"

base_item.variant_items << variant_item_1
