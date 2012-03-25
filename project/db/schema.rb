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

ActiveRecord::Schema.define(:version => 20120325021653) do

  create_table "areas", :force => true do |t|
    t.string "area_name",   :limit => 50,  :null => false
    t.string "description", :limit => 100
  end

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.string   "department"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "customer_types", :force => true do |t|
    t.string "type_name", :limit => 30
  end

  create_table "customers", :force => true do |t|
    t.string  "name",             :limit => 40
    t.string  "last_name",        :limit => 50
    t.string  "company_name",     :limit => 40
    t.string  "ruc",              :limit => 10
    t.string  "address",          :limit => 100
    t.integer "num_identify"
    t.string  "mobile_number",    :limit => 20
    t.string  "phone_number",     :limit => 20
    t.string  "email",            :limit => 60
    t.integer "customer_type_id"
  end

  create_table "employees", :force => true do |t|
    t.string  "email",            :limit => 30
    t.string  "name",             :limit => 30
    t.string  "last_name",        :limit => 30
    t.integer "num_identity"
    t.string  "address",          :limit => 60
    t.date    "admission_date"
    t.date    "birthday"
    t.decimal "salary"
    t.string  "mobile_number",    :limit => 20
    t.string  "phone_number",     :limit => 20
    t.integer "function_type_id"
  end

  create_table "foreign_companies", :force => true do |t|
    t.string "company_name"
    t.string "mobile_number"
    t.string "email"
    t.string "ruc"
    t.string "address"
    t.string "phone_number"
  end

  create_table "function_types", :force => true do |t|
    t.string   "description", :limit => 30, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "payment_methods", :force => true do |t|
    t.string "name_payment", :limit => 20, :null => false
    t.string "description",  :limit => 50
  end

  create_table "product_states", :force => true do |t|
    t.string "state_name",  :limit => 20,  :null => false
    t.string "description", :limit => 100
  end

  create_table "product_types", :force => true do |t|
    t.string "description", :limit => 30, :null => false
  end

  create_table "products", :force => true do |t|
    t.integer  "num_code",                        :null => false
    t.string   "description",      :limit => 100
    t.integer  "product_type_id",                 :null => false
    t.integer  "retire_note_id",                  :null => false
    t.string   "remitter",         :limit => 100
    t.string   "address",          :limit => 100
    t.string   "fragile",          :limit => 5,   :null => false
    t.integer  "product_state_id",                :null => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "reasons", :force => true do |t|
    t.string "description", :limit => 100, :null => false
  end

  create_table "receivers", :force => true do |t|
    t.string   "receiver_name"
    t.string   "address"
    t.integer  "city_id"
    t.string   "document"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "retire_note_details", :force => true do |t|
    t.integer "retire_note_id"
    t.integer "package_type_id"
    t.integer "amount"
    t.integer "city_id"
    t.decimal "unit_price"
    t.string  "description"
  end

  create_table "retire_notes", :force => true do |t|
    t.integer  "employee_id"
    t.datetime "date"
    t.integer  "service_type_id"
    t.integer  "customer_id"
    t.integer  "product_type_id"
    t.integer  "city_id"
    t.integer  "amount"
    t.string   "description",     :limit => 50
    t.decimal  "unit_price"
  end

  create_table "routing_sheet_states", :force => true do |t|
    t.string "state_name",  :limit => 50,  :null => false
    t.string "description", :limit => 100
  end

  create_table "routing_sheets", :force => true do |t|
    t.integer "area_id",                :null => false
    t.integer "employee_id",            :null => false
    t.date    "date"
    t.integer "total_amount"
    t.integer "routing_sheet_state_id", :null => false
    t.string  "commentary"
    t.string  "state"
  end

  create_table "service_types", :force => true do |t|
    t.string "description"
  end

  create_table "transport_guide_details", :force => true do |t|
    t.integer "transport_guide_id", :null => false
    t.integer "amount"
    t.integer "product_type_id",    :null => false
    t.decimal "weight"
  end

  create_table "transport_guide_states", :force => true do |t|
    t.string "name_state",  :limit => 40,  :null => false
    t.string "description", :limit => 100
  end

  create_table "transport_guides", :force => true do |t|
    t.string   "destination_person",       :limit => 60
    t.string   "destination_address",      :limit => 100
    t.string   "remitter_person",          :limit => 60
    t.string   "remitter_address",         :limit => 100
    t.integer  "num_guide",                               :null => false
    t.integer  "customer_id",                             :null => false
    t.integer  "foreign_company_id",                      :null => false
    t.integer  "employee_id",                             :null => false
    t.integer  "service_type_id",                         :null => false
    t.integer  "transport_guide_state_id",                :null => false
    t.integer  "payment_method_id",                       :null => false
    t.integer  "destination_city_id",                     :null => false
    t.integer  "origin_city_id",                          :null => false
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  add_foreign_key "customers", "customer_types", :name => "customers_customer_type_id_fk"

  add_foreign_key "employees", "function_types", :name => "employees_function_type_id_fk"

  add_foreign_key "products", "product_states", :name => "packages_package_state_id_fk"
  add_foreign_key "products", "product_types", :name => "packages_package_type_id_fk"
  add_foreign_key "products", "retire_notes", :name => "packages_retire_note_id_fk"

  add_foreign_key "receivers", "cities", :name => "receivers_city_id_fk"

  add_foreign_key "retire_note_details", "product_types", :name => "retire_note_details_package_type_id_fk", :column => "package_type_id"
  add_foreign_key "retire_note_details", "retire_notes", :name => "retire_note_details_retire_note_id_fk"

  add_foreign_key "retire_notes", "cities", :name => "retire_notes_city_id_fk"
  add_foreign_key "retire_notes", "customers", :name => "retire_notes_customer_id_fk"
  add_foreign_key "retire_notes", "employees", :name => "retire_notes_employee_id_fk"
  add_foreign_key "retire_notes", "product_types", :name => "retire_notes_product_type_id_fk"
  add_foreign_key "retire_notes", "service_types", :name => "retire_notes_service_type_id_fk"

  add_foreign_key "routing_sheets", "areas", :name => "routing_sheets_area_id_fk"
  add_foreign_key "routing_sheets", "employees", :name => "routing_sheets_employee_id_fk"
  add_foreign_key "routing_sheets", "routing_sheet_states", :name => "routing_sheets_routing_sheet_state_id_fk"

  add_foreign_key "transport_guide_details", "product_types", :name => "transport_guide_details_product_type_id_fk"
  add_foreign_key "transport_guide_details", "transport_guides", :name => "transport_guide_details_transport_guide_id_fk"

  add_foreign_key "transport_guides", "cities", :name => "fk_transport_guides_destination_city_id", :column => "destination_city_id"
  add_foreign_key "transport_guides", "cities", :name => "fk_transport_guides_origin_city_id", :column => "origin_city_id"
  add_foreign_key "transport_guides", "customers", :name => "transport_guides_customer_id_fk"
  add_foreign_key "transport_guides", "employees", :name => "transport_guides_employee_id_fk"
  add_foreign_key "transport_guides", "foreign_companies", :name => "transport_guides_foreign_company_id_fk"
  add_foreign_key "transport_guides", "payment_methods", :name => "transport_guides_payment_method_id_fk"
  add_foreign_key "transport_guides", "service_types", :name => "transport_guides_service_type_id_fk"
  add_foreign_key "transport_guides", "transport_guide_states", :name => "transport_guides_transport_guide_state_id_fk"

end
