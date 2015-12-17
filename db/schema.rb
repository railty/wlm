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

  create_table "CountryCode", primary_key: "COUNTRY_CODE", force: :cascade do |t|
    t.varchar "COUNTRY_NAME",  limit: 32
    t.varchar "OFFICIAL_NAME", limit: 64
  end

  create_table "Info_itemfile", primary_key: "UPC_GTIN", force: :cascade do |t|
    t.string  "UPC_CK_Digit",            limit: 1
    t.string  "Item_Description_1",      limit: 20
    t.string  "Shelf_1___Color",         limit: 6
    t.string  "Shelf_2___Size",          limit: 6
    t.string  "Unit_Size_UOM",           limit: 10
    t.string  "Unit_Size_Sell_Qty",      limit: 10
    t.string  "Plu_Number",              limit: 5
    t.float   "Base_Unit_Retail"
    t.integer "Department",              limit: 2
    t.string  "Country_of_Origin",       limit: 10
    t.string  "Retail_Unit_Measurement", limit: 10
    t.string  "Country_of_Origin_Name",  limit: 100
    t.string  "Converted_Price",         limit: 10
    t.string  "Unit_Price",              limit: 32
    t.varchar "Price_Per_LB",            limit: 20
  end

  create_table "ProductPrice", primary_key: "ProdNum", force: :cascade do |t|
    t.varchar "Grade",        limit: 20,                          null: false
    t.money   "RegPrice",                precision: 19, scale: 4
    t.money   "BottomPrice",             precision: 19, scale: 4
    t.money   "OnsalePrice",             precision: 19, scale: 4
    t.varchar "ModTimeStamp", limit: 14
    t.string  "Source",       limit: 15
  end

  create_table "Products", primary_key: "Prod_Num", force: :cascade do |t|
    t.varchar "Prod_Name",         limit: 50
    t.varchar "Prod_Desc",         limit: 80
    t.integer "Service",           limit: 4
    t.money   "Unit_Cost",                    precision: 19, scale: 4, null: false
    t.varchar "Measure",           limit: 50
    t.varchar "Warranty",          limit: 50
    t.money   "Tot_Sales",                    precision: 19, scale: 4
    t.money   "Tot_Profit",                   precision: 19, scale: 4
    t.integer "OnSales",           limit: 4
    t.varchar "Barcode",           limit: 20
    t.string  "Prod_Alias",        limit: 40
    t.integer "Serial_Control",    limit: 4
    t.integer "Tax1App",           limit: 2
    t.integer "Tax2App",           limit: 2
    t.integer "Tax3App",           limit: 2
    t.money   "ItemBonus",                    precision: 19, scale: 4
    t.integer "SalePoint",         limit: 4
    t.real    "ServiceComm"
    t.money   "GM_UCost",                     precision: 19, scale: 4
    t.money   "GM_ProdProfit",                precision: 19, scale: 4
    t.float   "QtySold"
    t.money   "LastyearSale",                 precision: 19, scale: 4
    t.money   "LastyearProfit",               precision: 19, scale: 4
    t.float   "LastyearQtySold"
    t.varchar "PackageSpec",       limit: 20
    t.money   "SuggestSalePrice",             precision: 19, scale: 4
    t.integer "PkLevel",           limit: 4
    t.varchar "MasterProdNum",     limit: 15
    t.float   "NumPerPack"
    t.varchar "PackageSpec2",      limit: 20
    t.integer "PkFraction",        limit: 4
    t.integer "PriceMode",         limit: 4
    t.varchar "ConvUnit",          limit: 20
    t.integer "ConvFactor",        limit: 4
    t.integer "QtySale",           limit: 4
    t.integer "QtySaleQty",        limit: 4
    t.float   "QtySalePrice"
    t.varchar "ModTimeStamp",      limit: 14
    t.integer "ScaleTray",         limit: 4
    t.integer "VolDisc",           limit: 4
    t.integer "VolQty1",           limit: 4
    t.float   "VolPrice1"
    t.integer "VolQty2",           limit: 4
    t.float   "VolPrice2"
    t.string  "Department",        limit: 20
    t.varchar "Last_Ord_Date",     limit: 10,                          null: false
    t.float   "On_Order",                                              null: false
    t.float   "Ord_Point",                                             null: false
    t.float   "SuggestOrderQty"
    t.integer "Inactive",          limit: 4
    t.varchar "EnvDepLink",        limit: 10
    t.integer "ExcludeOnRank",     limit: 2
    t.varchar "QtyGroup",          limit: 25
    t.float   "ProportionalTare"
    t.integer "Deduct_Bag_Weight", limit: 4
    t.float   "Bag_Weight"
    t.float   "MaxBuyQty"
    t.float   "MaxOnSaleQty"
    t.integer "isFood",            limit: 2,                           null: false
    t.string  "Source",            limit: 15
  end

  create_table "Products_Stores", id: false, force: :cascade do |t|
    t.varchar "Prod_Num",    limit: 15,                          null: false
    t.varchar "Store",       limit: 10
    t.varchar "Prod_Name",   limit: 50
    t.string  "Prod_Alias",  limit: 40
    t.money   "RegPrice",               precision: 19, scale: 4
    t.money   "OnSalePrice",            precision: 19, scale: 4
  end

  create_table "barcodes", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments", force: :cascade do |t|
    t.string   "name",       limit: 4000
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "itemfile", primary_key: "UPC_GTIN", force: :cascade do |t|
    t.string  "UPC_CK_Digit",                         limit: 1
    t.string  "Supplier_Stock_Number",                limit: 15
    t.string  "Item_Description_1",                   limit: 20
    t.string  "French_Item_Description_1",            limit: 20
    t.string  "Shelf_1___Color",                      limit: 6
    t.string  "French_Shelf_1___Color",               limit: 6
    t.string  "Shelf_2___Size",                       limit: 6
    t.string  "French_Shelf_2___Size",                limit: 6
    t.string  "Unit_Size_UOM",                        limit: 10
    t.string  "Unit_Size_Sell_Qty",                   limit: 10
    t.string  "Item_Description_2",                   limit: 20
    t.string  "French_Item_Description_2",            limit: 20
    t.string  "UPC_Description",                      limit: 12
    t.string  "French_UPC_Description",               limit: 12
    t.string  "Signing_Desc",                         limit: 40
    t.string  "French_Signing_Desc",                  limit: 40
    t.string  "Brand",                                limit: 40
    t.string  "Shop___Ticket_Description",            limit: 20
    t.string  "French_Shop___Ticket_Description",     limit: 20
    t.string  "Plu_Number",                           limit: 5
    t.string  "Case_UPC_Supplier_Pack",               limit: 15
    t.integer "Supplier_Pack_Qty",                    limit: 2
    t.float   "Supplier_Pack_Length"
    t.float   "Supplier_Pack_Width"
    t.float   "Supplier_Pack_Height"
    t.float   "Supplier_Pack_Weight"
    t.integer "Supplier_Min_Order_Qty",               limit: 2
    t.string  "Warehouse_Pack_UPC_Number",            limit: 15
    t.float   "Whse_Pack_Qty"
    t.float   "Whse_Pack_Length"
    t.float   "Whse_Pack_Width"
    t.float   "Whse_Pack_Height"
    t.float   "Whse_Pack_Weight"
    t.float   "Whse_Max_Order_Qty"
    t.string  "Special_Handling_Instructions",        limit: 40
    t.string  "French_Special_Handling_Instructions", limit: 40
    t.integer "Pallet_Ti",                            limit: 4
    t.integer "Pallet_Hi",                            limit: 4
    t.integer "Pallet_Round_Pct",                     limit: 4
    t.integer "Whse_Area",                            limit: 2
    t.integer "Marshal_ID",                           limit: 2
    t.string  "Conveyable",                           limit: 1
    t.string  "Master_Carton_Ind",                    limit: 1
    t.integer "Crush_Factor",                         limit: 2
    t.integer "Whse_Rotation",                        limit: 2
    t.string  "Unit_Cost",                            limit: 255
    t.float   "Base_Unit_Retail"
    t.float   "Supplier_Pack_Cost"
    t.float   "Mfgr_Pre_Price"
    t.float   "Mfgr_Suggested_Retail"
    t.string  "Item_Opp",                             limit: 1
    t.string  "Whse_Pack_Calc_Method",                limit: 1
    t.integer "Department",                           limit: 2
    t.string  "Supplier_Number",                      limit: 10
    t.string  "Item_Type",                            limit: 2
    t.string  "Sub_Type",                             limit: 2
    t.string  "Subclass",                             limit: 2
    t.string  "Fineline",                             limit: 4
    t.string  "Shelf_Number",                         limit: 7
    t.string  "Product_Number",                       limit: 7
    t.integer "Projected_Yearly_Sales_Qty",           limit: 4
    t.string  "Send_to_Store_Date",                   limit: 4000
    t.string  "Item_Effective_Date",                  limit: 4000
    t.string  "Item_Expiration_Date",                 limit: 4000
    t.string  "Performance_Rating",                   limit: 1
    t.string  "Corporate_Orderbook",                  limit: 1
    t.string  "eCommerce_Orderbook",                  limit: 1
    t.string  "Variety_Pack_Ind",                     limit: 1
    t.string  "Intangible_Ind",                       limit: 1
    t.string  "Country_of_Origin",                    limit: 10
    t.string  "Place_of_Manufacture",                 limit: 10
    t.string  "Factory_ID",                           limit: 10
    t.string  "Whse_Alignment",                       limit: 10
    t.string  "Warehouses_Stocked",                   limit: 10
    t.string  "Wal_Mart",                             limit: 1
    t.string  "Supercenter",                          limit: 1
    t.string  "Neighborhood_Market___Amigo",          limit: 1
    t.string  "Online",                               limit: 1
    t.string  "Send_Traits",                          limit: 10
    t.string  "Omit_Traits",                          limit: 10
    t.string  "Replaces_Item",                        limit: 10
    t.string  "Change_Reason_Code",                   limit: 10
    t.string  "Comment",                              limit: 120
    t.float   "Item_Length"
    t.float   "Item_Width"
    t.float   "Item_Height"
    t.float   "Item_Weight"
    t.string  "Guaranteed_Sales",                     limit: 1
    t.string  "Electronic_Article_Surveillance_Ind",  limit: 1
    t.string  "Temp_Sensitive_Ind",                   limit: 1
    t.string  "Shelf_Rotation",                       limit: 1
    t.string  "Modular_Batch_Print",                  limit: 1
    t.string  "Retail_Unit_Measurement",              limit: 10
    t.string  "Item_Scannable_Ind",                   limit: 1
    t.string  "Scalable_at_Register_Ind",             limit: 1
    t.string  "Backroom_Scale_Ind",                   limit: 1
    t.string  "Sold_by_Weight_Repl_by_Unit",          limit: 1
    t.float   "Shelf_Life_Days"
    t.float   "Min_Whse_Life_Qty"
    t.float   "Variance_Days"
    t.float   "Ideal_Temp_Lo"
    t.float   "Ideal_Temp_Hi"
    t.float   "Acceptable_Temp_Lo"
    t.float   "Acceptable_Temp_Hi"
    t.float   "Vnpk_Netwgt"
    t.string  "Acctg_Dept_Nbr",                       limit: 10
    t.string  "Supplier_Pack_Weight_Format",          limit: 1
    t.string  "Variable_Comp__Ind",                   limit: 1
    t.string  "Season_Code",                          limit: 10
    t.string  "Season_Year",                          limit: 4
    t.string  "Hazmat_Ind",                           limit: 1
    t.string  "Consideration_Code",                   limit: 10
    t.boolean "ConfirmedToPOS"
  end

  create_table "itemfile_wm", id: false, force: :cascade do |t|
    t.integer "Acct Dept Nbr",  limit: 4
    t.string  "Dept Desc",      limit: 255
    t.string  "UPC",            limit: 255
    t.string  "VNPK UPC",       limit: 255
    t.money   "Unit Retail",                precision: 19, scale: 4
    t.money   "Unit Cost",                  precision: 19, scale: 4
    t.string  "Unit Size",      limit: 255
    t.string  "Unit Size UOM",  limit: 255
    t.string  "Signing Desc",   limit: 255
    t.float   "VNPK Qty"
    t.string  "Item Flags",     limit: 255
    t.string  "Item Desc 1",    limit: 255
    t.string  "Vendor Stk Nbr", limit: 255
    t.string  "Size Desc",      limit: 255
    t.nchar   "Item Nbr",       limit: 10
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

  create_table "label_itemfile", primary_key: "UPC_GTIN", force: :cascade do |t|
    t.string  "UPC_CK_Digit",            limit: 1
    t.string  "Item_Description_1",      limit: 20
    t.string  "Shelf_1___Color",         limit: 6
    t.string  "Shelf_2___Size",          limit: 6
    t.string  "Unit_Size_UOM",           limit: 10
    t.string  "Unit_Size_Sell_Qty",      limit: 10
    t.string  "Plu_Number",              limit: 5
    t.float   "Base_Unit_Retail"
    t.integer "Department",              limit: 2
    t.string  "Country_of_Origin",       limit: 10
    t.string  "Retail_Unit_Measurement", limit: 10
    t.string  "Country_of_Origin_Name",  limit: 100
    t.string  "Converted_Price",         limit: 10
    t.string  "Unit_Price",              limit: 32
    t.varchar "Price_Per_LB",            limit: 20
  end

  create_table "ofmm_product_price", id: false, force: :cascade do |t|
    t.varchar "Prod_Num",    limit: 15,                          null: false
    t.money   "RegPrice",               precision: 19, scale: 4
    t.money   "OnSalePrice",            precision: 19, scale: 4
  end

  create_table "ofmm_products", id: false, force: :cascade do |t|
    t.varchar "Prod_Num",   limit: 15, null: false
    t.varchar "Prod_Name",  limit: 50
    t.string  "Prod_Alias", limit: 40
  end

  create_table "produce", id: false, force: :cascade do |t|
    t.string "Commodity",         limit: 255
    t.float  "WM PACK"
    t.float  "Store Cost"
    t.float  "Pack Size"
    t.string "LB/EA",             limit: 255
    t.float  "Unit Cost"
    t.float  "Store Retail"
    t.float  "kg price"
    t.float  "Margin"
    t.string "Country of Origin", limit: 255
    t.string "Stock #",           limit: 255
    t.nchar  "WM#",               limit: 10
    t.string "PLU/UPC",           limit: 255
    t.string "Comments",          limit: 255
    t.money  "Current_Price",                 precision: 19, scale: 4
  end

  create_table "produce_alp", id: false, force: :cascade do |t|
    t.string "Commodity",           limit: 255
    t.float  "WM PACK"
    t.float  "Store Cost"
    t.float  "Pack Size"
    t.string "LB/EA",               limit: 255
    t.float  "Unit Cost"
    t.float  "Store Retail"
    t.float  "kg price"
    t.float  "Margin"
    t.string "Country of Origin",   limit: 255
    t.string "Stock #",             limit: 255
    t.string "PLU/UPC",             limit: 255
    t.string "Comments",            limit: 255
    t.float  "Actual Store Retail"
    t.float  "Actual KG Price"
    t.nchar  "WM#",                 limit: 10
  end

  create_table "produce_shared", id: false, force: :cascade do |t|
    t.string "Commodity",         limit: 255
    t.float  "WM PACK"
    t.float  "Store Cost"
    t.float  "Pack Size"
    t.string "LB/EA",             limit: 255
    t.float  "Unit Cost"
    t.float  "Store Retail"
    t.float  "kg price"
    t.float  "Margin"
    t.string "Country of Origin", limit: 255
    t.string "Stock #",           limit: 255
    t.string "PLU/UPC",           limit: 255
    t.string "Comments",          limit: 255
    t.string "WM Retail",         limit: 255
    t.nchar  "WM#",               limit: 10
  end

  create_table "produce_wm", id: false, force: :cascade do |t|
    t.float  "Prime Item Nbr"
    t.string "Prime Item Desc",               limit: 255
    t.string "Signing Desc",                  limit: 255
    t.string "UPC",                           limit: 255
    t.money  "Unit Retail",                               precision: 19, scale: 4
    t.money  "Store Specific Retail",                     precision: 19, scale: 4
    t.money  "Current HO Retail",                         precision: 19, scale: 4
    t.string "Order book Flag",               limit: 255
    t.float  "Curr Valid Store/Item Comb#"
    t.float  "Curr Traited Store/Item Comb#"
    t.string "Unit Size UOM",                 limit: 255
    t.string "UOM Sell Qty",                  limit: 255
    t.string "UOM Code",                      limit: 255
    t.string "Size Desc",                     limit: 255
    t.string "Vendor Nbr",                    limit: 255
    t.string "Vendor Name",                   limit: 255
    t.string "Fineline Number",               limit: 255
    t.string "Fineline Description",          limit: 255
  end

  create_table "t_ProdList", id: false, force: :cascade do |t|
    t.string "Product_ID", limit: 13, null: false
  end

  create_table "t_Temp1", id: false, force: :cascade do |t|
    t.string  "UPC_GTIN",                limit: 13,  null: false
    t.string  "UPC_CK_Digit",            limit: 1
    t.string  "Item_Description_1",      limit: 20
    t.string  "Shelf_1___Color",         limit: 6
    t.string  "Shelf_2___Size",          limit: 6
    t.string  "Unit_Size_UOM",           limit: 10
    t.string  "Unit_Size_Sell_Qty",      limit: 10
    t.string  "Plu_Number",              limit: 5
    t.float   "Base_Unit_Retail"
    t.integer "Department",              limit: 2
    t.string  "Country_of_Origin",       limit: 10
    t.string  "Retail_Unit_Measurement", limit: 10
    t.string  "Country_of_Origin_Name",  limit: 100
    t.string  "Converted_Price",         limit: 10
    t.string  "Unit_Price",              limit: 32
    t.varchar "Price_Per_LB",            limit: 20
  end

end
