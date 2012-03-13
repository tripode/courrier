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

ActiveRecord::Schema.define(:version => 20120313001647) do

  create_table "areas", :force => true do |t|
    t.string "area_name",   :limit => 20, :null => false
    t.string "description", :limit => 50
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

  create_table "package_states", :force => true do |t|
    t.string "state_name",  :limit => 20,  :null => false
    t.string "description", :limit => 100
  end

  create_table "package_types", :force => true do |t|
    t.string "description", :limit => 30, :null => false
  end

  create_table "packages", :force => true do |t|
    t.integer  "num_code",                        :null => false
    t.string   "description",      :limit => 100
    t.integer  "package_type_id",                 :null => false
    t.integer  "retire_note_id",                  :null => false
    t.integer  "employee_id",                     :null => false
    t.string   "remitter",         :limit => 100
    t.string   "address",          :limit => 100
    t.integer  "customer_id",                     :null => false
    t.string   "fragile",          :limit => 5,   :null => false
    t.integer  "package_state_id",                :null => false
    t.date     "admission_date"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "reasons", :force => true do |t|
    t.string "description", :limit => 100, :null => false
  end

  create_table "retire_notes", :force => true do |t|
    t.integer  "employee_id"
    t.datetime "date"
    t.integer  "service_type_id"
    t.integer  "customer_id"
  end

  create_table "rounting_sheets", :force => true do |t|
    t.integer "area_id",      :null => false
    t.integer "employee_id",  :null => false
    t.date    "date"
    t.integer "total_amount"
  end

  create_table "service_types", :force => true do |t|
    t.string "description"
  end

  create_table "transport_guides", :force => true do |t|
    t.integer "employee_id",                       :null => false
    t.date    "date"
    t.integer "service_type_id",                   :null => false
    t.integer "customer_id",                       :null => false
    t.integer "foreign_company_id",                :null => false
    t.integer "area_id",                           :null => false
    t.string  "description",        :limit => 100
  end

  add_foreign_key "customers", "customer_types", :name => "customers_customer_type_id_fk"

  add_foreign_key "employees", "function_types", :name => "employees_function_type_id_fk"

  add_foreign_key "packages", "customers", :name => "packages_customer_id_fk"
  add_foreign_key "packages", "employees", :name => "packages_employee_id_fk"
  add_foreign_key "packages", "package_states", :name => "packages_package_state_id_fk"
  add_foreign_key "packages", "package_types", :name => "packages_package_type_id_fk"
  add_foreign_key "packages", "retire_notes", :name => "packages_retire_note_id_fk"

  add_foreign_key "retire_notes", "customers", :name => "retire_notes_customer_id_fk"
  add_foreign_key "retire_notes", "employees", :name => "retire_notes_employee_id_fk"
  add_foreign_key "retire_notes", "service_types", :name => "retire_notes_service_type_id_fk"

  add_foreign_key "rounting_sheets", "areas", :name => "rounting_sheets_area_id_fk"
  add_foreign_key "rounting_sheets", "employees", :name => "rounting_sheets_employee_id_fk"

  add_foreign_key "transport_guides", "areas", :name => "transport_guides_area_id_fk"
  add_foreign_key "transport_guides", "customers", :name => "transport_guides_customer_id_fk"
  add_foreign_key "transport_guides", "employees", :name => "transport_guides_employee_id_fk"
  add_foreign_key "transport_guides", "foreign_companies", :name => "transport_guides_foreign_company_id_fk"
  add_foreign_key "transport_guides", "service_types", :name => "transport_guides_service_type_id_fk"

end
