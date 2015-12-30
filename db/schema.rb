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

ActiveRecord::Schema.define(version: 20151217163746) do

  create_table "departments", force: :cascade do |t|
    t.string   "name",       limit: 4000
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "items", force: :cascade do |t|
    t.integer  "department_id",        limit: 4
    t.string   "upc",                  limit: 13
    t.string   "vnpk_upc",             limit: 13
    t.decimal  "unit_retail",                       precision: 6,  scale: 2
    t.decimal  "unit_cost",                         precision: 6,  scale: 2
    t.decimal  "unit_size",                         precision: 18, scale: 0
    t.string   "unit_size_uom",        limit: 4000
    t.string   "signing_desc",         limit: 4000
    t.decimal  "vnpk_qty",                          precision: 18, scale: 0
    t.string   "item_flags",           limit: 4000
    t.string   "item_desc_1",          limit: 4000
    t.string   "vendor_stk_nbr",       limit: 4000
    t.string   "size_desc",            limit: 4000
    t.decimal  "fineline_number",                   precision: 18, scale: 0
    t.string   "fineline_description", limit: 4000
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
  end

end
