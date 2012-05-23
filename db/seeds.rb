base_item = Item.create :name => "Base Item"
variant_item_1 = Item.create :name => "Variant Item 1"

base_item.variant_items << variant_item_1

=begin
  SETUP CODE
  create category  -> Item classification 
  create sub category  -> Item classification 
  create property -> For the variations 
  create values corresponding to the property -> For the variations 
  create brands -> Storing the discount information. 
=end

root_male_category = Category.create_root_category(:title => "Male")
root_female_category = Category.create_root_category(:title => "Female")

top_female_sub_cat_1 = root_female_category.create_sub_category(:title => "Bra")
top_female_sub_cat_2 = root_female_category.create_sub_category(:title => "Blouse")
top_female_sub_cat_3 = root_female_category.create_sub_category(:title => "Shirt")

top_male_sub_cat_1 = root_male_category.create_sub_category(:title => "Tie")
top_male_sub_cat_2 = root_male_category.create_sub_category(:title => "Jacket")
top_male_sub_cat_3 = root_male_category.create_sub_category(:title => "Sleeveless")

puts "Done with the category creation"
property_size = Property.create(:name => "Size" )
small_size_value = property_size.create_value(:name => "S", :description => "Small")
medium_size_value = property_size.create_value(:name => "M", :description => "Medium")
large_size_value = property_size.create_value(:name => "L", :description => "Large")

puts "Created the size property"

property_color = Property.create(:name => "Color")
red_color_value = property_color.create_value(:name => "Red")
green_color_value = property_color.create_value(:name => "Green" )
blue_color_value = property_color.create_value(:name => "Blue" )
black_color_value = property_color.create_value(:name => "Black" )

puts "Created the color property"

ajijah_brand = Brand.create(:name => "Ajijah", :member_discount => 15, :stockist_discount => 20 )
secondskin_brand = Brand.create(:name => "SecondSkin", :member_discount => 20, :stockist_discount => 30 )

puts "created the brand"

=begin
  Add suppliers in the first place. 
  Supplier can offer items (upload the picture, basic information, and variations )
=end

hamdani_supplier = Supplier.create :name => "Hamdani" 
atong_supplier = Supplier.create :name => "Atong"

=begin
  But supplier game is the long run. In the short run, the employee, on behalf of supplier, uploads
  the items. 
  
  Create Role
  Create User
  Assign Role to User 
=end

sales_manager_role = Role.create :name => USER_ROLE[:sales_manager]
customer_service_role = Role.create :name => USER_ROLE[:customer_service]
warehouse_officer_role = Role.create :name => USER_ROLE[:warehouse_officer]
product_creator_role = Role.create :name => USER_ROLE[:product_creator]
# warehouse officer will do the data entry, on the item received and item going out. approval by the warehouse manager

sales_manager  = User.create :email => "sales_manager@gmail.com", :password => "willy1234",
                            :password_confirmation => "willy1234"
                            
product_creator  = User.create :email => "product_creator@gmail.com", :password => "willy1234",
                            :password_confirmation => "willy1234"
              
customer_service  = User.create :email => "customer_service@gmail.com", :password => "willy1234",
                            :password_confirmation => "willy1234"
                            
warehouse_officer  = User.create :email => "warehouse_officer@gmail.com", :password => "willy1234",
                            :password_confirmation => "willy1234"
                    
                            
sales_manager.roles << sales_manager_role 
product_creator.roles << product_creator_role 
customer_service.roles << customer_service_role
warehouse_officer.roles << warehouse_officer_role 

puts "Done creating the users"


# product_creator.create_item_on_behalf_of_supplier(supplier, item_name, brand, property_value_list )
# they select the property, and values for that property appears. They select the value, 
  # a hidden input field will be filled in. name => properties[property_#{property_id}], value => the selected value 
  
  # there should be a helper, extracting the property-value -> Make it into an array [ [p1,v1], [p2,v2]]
  # if the variant item property-value is exactly similar to base item, false 
  

  # at least, it has to have one property . Katalog -> property : edition, year 
# product_creator.create_variant_item_on_behalf_of_supplier(base_item, supplier, item_name, brand, property_value_list)

# 2ndSkin condition => data migration in the short run 
Product.direct_promote_base_item_to_product_on_behalf_of_supplier(product_creator, supplier, 
                            item_params, 
                            brand, property_value_list, price, base_price, current_quantity )

# create the variations

Product.direct_promote_variant_item_to_product_on_behalf_of_supplier(product_creator,supplier, 
                            base_item,  # name is taken from the base item 
                            brand, property_value_list, price, base_price, current_quantity )
                            
# keep creating several products and its variant 

# in the migration, it alwayys come with the current quantity -> Initial Setup, no documents 


# item without category? it is cool bro.. not that important. Category is just for data display
# not impacting the continuous data evolution . It is optional. Category should sticks to item, not product

# product creation is OK, with the final price attached. But we need the base price 

# then, add the quantity. There has to be documents to add the quantity
# Incoming documents: from the PO -> Receipt Delivery
# incoming documents: from the customer 
# Incoming Documents: data migration 






