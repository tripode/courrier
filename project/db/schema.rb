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

ActiveRecord::Schema.define(:version => 20120311023047) do

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

  create_table "service_types", :force => true do |t|
    t.string "description"
  end

  add_foreign_key "customers", "customer_types", :name => "customers_customer_type_id_fk"

  add_foreign_key "employees", "function_types", :name => "employees_function_type_id_fk"

end
