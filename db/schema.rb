# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120522154232) do

  create_table "assignments", :force => true do |t|
    t.integer  "role_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "brands", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "member_discount"
    t.integer  "stockist_discount"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "is_root_category",          :default => false
    t.integer  "direct_parent_category_id"
    t.integer  "absolute_depth",                               :null => false
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  create_table "category_edges", :force => true do |t|
    t.integer  "category_id"
    t.integer  "sub_category_id"
    t.integer  "delta"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "item_batches", :force => true do |t|
    t.decimal  "item_price",         :precision => 9, :scale => 2, :default => 0.0
    t.integer  "quantity_purchased"
    t.integer  "quantity_received"
    t.integer  "quantity_sold"
    t.boolean  "is_finished",                                      :default => false
    t.integer  "item_id"
    t.integer  "purchase_order_id"
    t.datetime "created_at",                                                          :null => false
    t.datetime "updated_at",                                                          :null => false
  end

  create_table "items", :force => true do |t|
    t.integer  "supplier_id"
    t.string   "name"
    t.integer  "base_item_id"
    t.boolean  "is_base_item", :default => true
    t.integer  "category_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "price_histories", :force => true do |t|
    t.decimal  "price",            :precision => 9, :scale => 2, :default => 0.0
    t.integer  "product_id"
    t.integer  "price_changer_id"
    t.datetime "created_at",                                                      :null => false
    t.datetime "updated_at",                                                      :null => false
  end

  create_table "product_memberships", :force => true do |t|
    t.integer  "item_id"
    t.integer  "product_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "products", :force => true do |t|
    t.decimal  "price",              :precision => 9, :scale => 2, :default => 0.0
    t.integer  "product_type",                                     :default => 0
    t.integer  "brand_id"
    t.integer  "product_creator_id"
    t.datetime "created_at",                                                        :null => false
    t.datetime "updated_at",                                                        :null => false
  end

  create_table "properties", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "property_values", :force => true do |t|
    t.integer  "property_id"
    t.integer  "value_id"
    t.integer  "item_id"
    t.integer  "position"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "suppliers", :force => true do |t|
    t.string   "name"
    t.text     "address"
    t.text     "other_information"
    t.string   "phone_number"
    t.string   "bbm_pin"
    t.string   "contact_person_name"
    t.string   "contact_person_phone_number"
    t.string   "contact_person_bbm_pin"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "values", :force => true do |t|
    t.string   "name"
    t.integer  "property_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "variants", :force => true do |t|
    t.integer  "item_id"
    t.integer  "variant_item_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
