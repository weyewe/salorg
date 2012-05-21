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

ActiveRecord::Schema.define(:version => 20120521152349) do

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

  create_table "items", :force => true do |t|
    t.integer  "supplier_id"
    t.string   "name"
    t.integer  "base_item_id"
    t.boolean  "is_base_item", :default => true
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
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

  create_table "variants", :force => true do |t|
    t.integer  "item_id"
    t.integer  "variant_item_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
