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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160228190048) do

  create_table "departments", force: :cascade do |t|
    t.string   "name",       limit: 32
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "items", force: :cascade do |t|
    t.integer  "department_id",          limit: 4
    t.string   "upc",                    limit: 13
    t.string   "vnpk_upc",               limit: 13
    t.decimal  "unit_retail",                         precision: 6,  scale: 2
    t.decimal  "unit_cost",                           precision: 6,  scale: 2
    t.decimal  "unit_size",                           precision: 18, scale: 0
    t.string   "unit_size_uom",          limit: 4000
    t.string   "signing_desc",           limit: 4000
    t.decimal  "vnpk_qty",                            precision: 18, scale: 0
    t.string   "item_flags",             limit: 4000
    t.string   "item_desc_1",            limit: 4000
    t.string   "vendor_stk_nbr",         limit: 4000
    t.string   "size_desc",              limit: 4000
    t.decimal  "fineline_number",                     precision: 18, scale: 0
    t.string   "fineline_description",   limit: 4000
    t.datetime "created_at",                                                   null: false
    t.datetime "updated_at",                                                   null: false
    t.char     "origin",                 limit: 2
    t.decimal  "current_price",                       precision: 6,  scale: 2
    t.decimal  "proposed_price",                      precision: 6,  scale: 2
    t.decimal  "price_ceiling",                       precision: 6,  scale: 2
    t.decimal  "proposed_price_ceiling",              precision: 6,  scale: 2
    t.string   "state",                  limit: 4000
    t.string   "notes",                  limit: 4000
    t.decimal  "vnpk_cost",                           precision: 6,  scale: 2
    t.string   "owner",                  limit: 4000
    t.string   "grade",                  limit: 4000
  end

  create_table "jobs", force: :cascade do |t|
    t.string   "name",         limit: 4000
    t.string   "job_type",     limit: 4000
    t.string   "input",        limit: 4000
    t.string   "output",       limit: 4000
    t.string   "state",        limit: 4000
    t.string   "stdout",       limit: 4000
    t.string   "stderr",       limit: 4000
    t.datetime "enqueued_at"
    t.datetime "started_at"
    t.datetime "completed_at"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "photos", force: :cascade do |t|
    t.integer  "item_id",            limit: 4
    t.string   "photo_type",         limit: 4000
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "image_file_name",    limit: 4000
    t.string   "image_content_type", limit: 4000
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
  end

  create_table "products_stores", primary_key: "Prod_Num", force: :cascade do |t|
    t.string  "Store",       limit: 10
    t.string  "Prod_Name",   limit: 50
    t.string  "Prod_Alias",  limit: 40
    t.decimal "RegPrice",               precision: 6, scale: 2
    t.decimal "OnSalePrice",            precision: 6, scale: 2
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 4000, default: "", null: false
    t.string   "encrypted_password",     limit: 4000, default: "", null: false
    t.string   "reset_password_token",   limit: 4000
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,    default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 4000
    t.string   "last_sign_in_ip",        limit: 4000
    t.string   "role",                   limit: 4000
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  create_table "wm_items", primary_key: "Item_Nbr", force: :cascade do |t|
    t.integer "Acct_Dept_Nbr",        limit: 4
    t.string  "Dept_Desc",            limit: 4000
    t.string  "UPC",                  limit: 13
    t.string  "VNPK_UPC",             limit: 13
    t.decimal "Unit_Retail",                       precision: 6,  scale: 2
    t.decimal "Unit_Cost",                         precision: 6,  scale: 2
    t.decimal "Unit_Size",                         precision: 18, scale: 0
    t.string  "Unit_Size_UOM",        limit: 4000
    t.string  "Signing_Desc",         limit: 4000
    t.decimal "VNPK_Qty",                          precision: 18, scale: 0
    t.string  "Item_Flags",           limit: 4000
    t.string  "Item_Desc_1",          limit: 4000
    t.string  "Vendor_Stk_Nbr",       limit: 4000
    t.string  "Size_Desc",            limit: 4000
    t.integer "Fineline_Number",      limit: 4
    t.string  "Fineline_Description", limit: 4000
    t.decimal "VNPK_Cost",                         precision: 6,  scale: 2
    t.string  "Item_Status",          limit: 4000
    t.string  "Item_Type",            limit: 4000
    t.date    "Effective_Date"
    t.date    "Create_Date"
    t.string  "Source",               limit: 4000
  end

end
