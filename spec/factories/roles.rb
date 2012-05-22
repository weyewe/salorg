
# USER_ROLE = {
#   :sales_manager => "SalesManager",
#   :product_creator => "ProductCreator",
#   :customer_service => "CustomerService",
#   :warehouse_officer => "WarehouseOfficer"
# }
# 


FactoryGirl.define do
  factory :role do
    name "The role"
  end
  
  factory :sales_manager_role, parent: :role do 
    name USER_ROLE[:sales_manager]
  end
  
  factory :product_creator_role, parent: :role do 
    name USER_ROLE[:product_creator]
  end
  
  factory :customer_service_role, parent: :role do 
    name USER_ROLE[:customer_service]
  end
  
  factory :warehouse_officer_role, parent: :role do 
    name USER_ROLE[:warehouse_officer]
  end
end

