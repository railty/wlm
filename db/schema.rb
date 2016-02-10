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

ActiveRecord::Schema.define(version: 20160210150533) do

  create_table "AP", primary_key: "ProdNum", force: :cascade do |t|
    t.string "Name",    limit: 50
    t.string "Name_cn", limit: 50
    t.string "Spec",    limit: 50
  end

  create_table "Categories", id: false, force: :cascade do |t|
    t.string "Category_ID",      limit: 2
    t.string "Category",         limit: 50
    t.string "Category_Chinese", limit: 50
  end

  create_table "CountryCode", primary_key: "COUNTRY_CODE", force: :cascade do |t|
    t.varchar "COUNTRY_NAME",  limit: 32
    t.varchar "OFFICIAL_NAME", limit: 64
  end

  create_table "Dlt_ProdNum", id: false, force: :cascade do |t|
    t.varchar "Prod_Num", limit: 15, null: false
  end

  create_table "Dlt_Product", id: false, force: :cascade do |t|
    t.varchar "Prod_Num",          limit: 15,                          null: false
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
    t.varchar "Prod_Alias",        limit: 40
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
    t.varchar "Department",        limit: 20
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
    t.string  "DeptCode",          limit: 2,                           null: false
    t.string  "Level2Code",        limit: 2,                           null: false
    t.string  "Level3Code",        limit: 2,                           null: false
    t.string  "SourceCode",        limit: 5,                           null: false
    t.string  "BrandCode",         limit: 5,                           null: false
    t.string  "InventoryLink",     limit: 15,                          null: false
    t.integer "OSQtySale",         limit: 2,                           null: false
    t.integer "OSQtySaleQty",      limit: 4,                           null: false
    t.money   "OSQtySalePrice",               precision: 19, scale: 4, null: false
    t.string  "LabelSz",           limit: 2,                           null: false
    t.integer "QtySale_L2",        limit: 2,                           null: false
    t.integer "QtySaleQty_L2",     limit: 4,                           null: false
    t.float   "QtySalePrice_L2",                                       null: false
    t.integer "OSQtySale_L2",      limit: 2,                           null: false
    t.integer "OSQtySaleQty_L2",   limit: 4,                           null: false
    t.float   "OSQtySalePrice_L2",                                     null: false
    t.string  "ShortCode",         limit: 15,                          null: false
    t.string  "ModByUser",         limit: 10
  end

  create_table "Dlt_ProductPrice", id: false, force: :cascade do |t|
    t.varchar "ProdNum",      limit: 15,                          null: false
    t.varchar "Grade",        limit: 20,                          null: false
    t.money   "RegPrice",                precision: 19, scale: 4
    t.money   "BottomPrice",             precision: 19, scale: 4
    t.money   "OnsalePrice",             precision: 19, scale: 4
    t.varchar "ModTimeStamp", limit: 14
  end

  create_table "Employee Privileges", primary_key: "ID", force: :cascade do |t|
    t.integer "Employee ID",  limit: 4
    t.integer "Privilege ID", limit: 4
    t.string  "UserID",       limit: 255
    t.string  "Password",     limit: 255
  end

  create_table "Employees", primary_key: "ID", force: :cascade do |t|
    t.integer "Store_ID",       limit: 4
    t.string  "Last Name",      limit: 50
    t.string  "First Name",     limit: 50
    t.string  "E-mail Address", limit: 50
    t.string  "Job Title",      limit: 50
    t.string  "Business Phone", limit: 25
    t.string  "Home Phone",     limit: 25
    t.string  "Mobile Phone",   limit: 25
    t.string  "Fax Number",     limit: 25
    t.text    "Address",        limit: 2147483647
    t.string  "City",           limit: 50
    t.string  "Province",       limit: 50
    t.string  "Postal Code",    limit: 15
    t.text    "Notes",          limit: 2147483647
    t.text    "Attachments",    limit: 2147483647
    t.string  "Password",       limit: 32
  end

  create_table "IItem", id: false, force: :cascade do |t|
    t.varchar "Prod_Num",      limit: 15,                          null: false
    t.float   "Ship_Quantity",                                     null: false
    t.money   "Unit_Price",               precision: 19, scale: 4, null: false
    t.varchar "Date_Sent",     limit: 10
    t.money   "Unit_Cost",                precision: 19, scale: 4
    t.money   "Tax1",                     precision: 19, scale: 4
    t.money   "Tax2",                     precision: 19, scale: 4
  end

  create_table "Inventories", primary_key: "ID", force: :cascade do |t|
    t.integer  "Store_ID",         limit: 4
    t.string   "Product_ID",       limit: 255
    t.datetime "SumStartDate"
    t.datetime "SumEndDate"
    t.integer  "ReceivedQuantity", limit: 4
    t.money    "ReceivedAvgPrice",             precision: 19, scale: 4
  end

  create_table "Inventory_Actions", primary_key: "ID", force: :cascade do |t|
    t.integer  "Supplier_ID",   limit: 4,          null: false
    t.string   "Action",        limit: 2,          null: false
    t.boolean  "Completed",                        null: false
    t.datetime "Complete_Time"
    t.string   "Product_ID",    limit: 15,         null: false
    t.float    "Quantity",                         null: false
    t.float    "Price"
    t.string   "Complete_User", limit: 50
    t.datetime "Action_Time",                      null: false
    t.binary   "Signature",     limit: 2147483647
    t.string   "PO_ID",         limit: 50
    t.string   "BATCH_ID",      limit: 10
  end

  create_table "Inventory_Last_Month", id: false, force: :cascade do |t|
    t.varchar "Product_ID",      limit: 15, null: false
    t.date    "D1"
    t.date    "D2"
    t.float   "Sold_Units",                 null: false
    t.float   "Sold_Amount",                null: false
    t.float   "Sold_Tax",                   null: false
    t.float   "Loss_Units",                 null: false
    t.float   "Receiving_Units",            null: false
  end

  create_table "Inventory_Last_Week", id: false, force: :cascade do |t|
    t.varchar "Product_ID",      limit: 15, null: false
    t.date    "D1"
    t.date    "D2"
    t.float   "Sold_Units",                 null: false
    t.float   "Sold_Amount",                null: false
    t.float   "Sold_Tax",                   null: false
    t.float   "Loss_Units",                 null: false
    t.float   "Receiving_Units",            null: false
  end

  create_table "Inventory_Staging", id: false, force: :cascade do |t|
    t.varchar  "Product_ID",        limit: 15, null: false
    t.datetime "LastInspectedDate"
    t.float    "Inspected_Units",              null: false
    t.float    "Sold_Units",                   null: false
    t.float    "Sold_Amount",                  null: false
    t.float    "Sold_Tax",                     null: false
    t.float    "Loss_Units",                   null: false
    t.float    "Receiving_Units",              null: false
    t.datetime "D2",                           null: false
    t.float    "D2_Inventory",                 null: false
    t.datetime "D1"
    t.float    "Sold_Units2",                  null: false
    t.float    "Sold_Amount2",                 null: false
    t.float    "Sold_Tax2",                    null: false
    t.float    "Loss_Units2",                  null: false
    t.float    "Receiving_Units2",             null: false
    t.float    "D1_Inventory",                 null: false
  end

  create_table "Inventory_Staging_30", id: false, force: :cascade do |t|
    t.varchar  "Product_ID",        limit: 15, null: false
    t.datetime "LastInspectedDate"
    t.float    "Inspected_Units",              null: false
    t.float    "Sold_Units",                   null: false
    t.float    "Sold_Amount",                  null: false
    t.float    "Sold_Tax",                     null: false
    t.float    "Loss_Units",                   null: false
    t.float    "Receiving_Units",              null: false
    t.datetime "D2",                           null: false
    t.float    "D2_Inventory",                 null: false
    t.datetime "D1"
    t.float    "Sold_Units2",                  null: false
    t.float    "Sold_Amount2",                 null: false
    t.float    "Sold_Tax2",                    null: false
    t.float    "Loss_Units2",                  null: false
    t.float    "Receiving_Units2",             null: false
    t.float    "D1_Inventory",                 null: false
  end

  create_table "Invoice_Item", primary_key: "Invoice_Num", force: :cascade do |t|
    t.varchar "Prod_Num",        limit: 15,                                           null: false
    t.float   "Ship_Quantity",                                        default: 0.0,   null: false
    t.money   "Unit_Price",                  precision: 19, scale: 4, default: 0.0,   null: false
    t.money   "Extended_Price",              precision: 19, scale: 4, default: 0.0,   null: false
    t.integer "OnSale",          limit: 4,                            default: 0
    t.varchar "Date_Sent",       limit: 10
    t.money   "Unit_Cost",                   precision: 19, scale: 4, default: 0.0
    t.varchar "Barcode",         limit: 15
    t.money   "Cost2",                       precision: 19, scale: 4, default: 0.0
    t.integer "ItemNumber",      limit: 4,                            default: 1,     null: false
    t.varchar "TX",              limit: 5
    t.money   "Tax1",                        precision: 19, scale: 4, default: 0.0
    t.money   "Tax2",                        precision: 19, scale: 4, default: 0.0
    t.integer "DocType",         limit: 4,                            default: 0
    t.money   "RegularPrice",                precision: 19, scale: 4, default: 0.0
    t.real    "DiscountRate",                                         default: 0.0
    t.integer "Member_Type",     limit: 4,                            default: 0
    t.varchar "Cust_Num",        limit: 20,                           default: "N/A"
    t.float   "SuggRetailPrice",                                      default: 0.0
    t.float   "OrderQty",                                             default: 0.0
    t.integer "SNControl",       limit: 4,                            default: 0
    t.varchar "Remark",          limit: 100,                          default: ""
  end

  create_table "Label_Products", id: false, force: :cascade do |t|
    t.varchar "Prod_Num",               limit: 15, null: false
    t.varchar "Name",                   limit: 50
    t.string  "Second_Name",            limit: 40
    t.string  "Department",             limit: 20
    t.varchar "Spec",                   limit: 20
    t.varchar "Measure",                limit: 50
    t.varchar "Origin",                 limit: 80
    t.varchar "Reg_Price",              limit: 8
    t.varchar "OnSale_Price",           limit: 8
    t.char    "OnSale_Start",           limit: 10
    t.char    "OnSale_End",             limit: 10
    t.varchar "Tax",                    limit: 5
    t.varchar "Quantity_Sale_Quantity", limit: 5
    t.varchar "Quantity_Sale_Price",    limit: 8
    t.string  "Location_Code",          limit: 32
    t.varchar "Misc_1",                 limit: 32
    t.varchar "Misc_2",                 limit: 32
    t.varchar "Misc_3",                 limit: 32
    t.varchar "Misc_4",                 limit: 32
    t.float   "MaxBuyQty"
    t.float   "MaxOnSaleQty"
    t.string  "Location_code2",         limit: 32
  end

  create_table "Multiple_Supplier_Products", primary_key: "ID", force: :cascade do |t|
    t.string   "Barcode",      limit: 15,                          null: false
    t.varchar  "Name",         limit: 50
    t.string   "Name2",        limit: 40
    t.integer  "Current #",    limit: 4,                           null: false
    t.string   "Department",   limit: 20
    t.varchar  "SPEC",         limit: 20
    t.string   "Rank",         limit: 2
    t.string   "Location",     limit: 32
    t.varchar  "Prod_Desc",    limit: 80
    t.money    "RegPrice",                precision: 19, scale: 4
    t.money    "OnSale$",                 precision: 19, scale: 4
    t.integer  "OnSales",      limit: 4
    t.integer  "QtySale",      limit: 4
    t.integer  "QtySale#",     limit: 4
    t.float    "QtySale$"
    t.varchar  "Tax",          limit: 3,                           null: false
    t.decimal  "Ordered",                 precision: 8,  scale: 2
    t.decimal  "Lst Rcv $",               precision: 8,  scale: 2
    t.float    "Lst Rcv #"
    t.integer  "Lst Rcv UPP",  limit: 4
    t.decimal  "Lwst Rcv $",              precision: 8,  scale: 2
    t.varchar  "LSale Date",   limit: 10,                          null: false
    t.integer  "LSale Day",    limit: 4,                           null: false
    t.varchar  "LInv Date",    limit: 10,                          null: false
    t.float    "Last Wk Sale"
    t.integer  "Supplier_ID",  limit: 4
    t.float    "Quantity"
    t.varchar  "User",         limit: 50
    t.datetime "Time"
  end

  create_table "Multiple_Suppliers", id: false, force: :cascade do |t|
    t.string  "Product_ID",  limit: 15, null: false
    t.integer "Supplier_ID", limit: 4,  null: false
    t.float   "Quantity"
  end

  create_table "OnSaleProduct", id: false, force: :cascade do |t|
    t.varchar "StartDate",  limit: 10, null: false
    t.varchar "EndDate",    limit: 10, null: false
    t.varchar "ProdNum",    limit: 15, null: false
    t.varchar "TargetType", limit: 4,  null: false
    t.varchar "TargetID",   limit: 20, null: false
    t.integer "MemberOnly", limit: 2,  null: false
    t.integer "D0",         limit: 2
    t.integer "D1",         limit: 2
    t.integer "D2",         limit: 2
    t.integer "D3",         limit: 2
    t.integer "D4",         limit: 2
    t.integer "D5",         limit: 2
    t.integer "D6",         limit: 2
  end

  create_table "OnSaleSchedule", id: false, force: :cascade do |t|
    t.varchar "StartDate",    limit: 10, null: false
    t.varchar "EndDate",      limit: 10, null: false
    t.varchar "TargetType",   limit: 4,  null: false
    t.varchar "TargetID",     limit: 20, null: false
    t.real    "GroupDiscPct"
    t.integer "MemberOnly",   limit: 2,  null: false
    t.integer "D0",           limit: 2
    t.integer "D1",           limit: 2
    t.integer "D2",           limit: 2
    t.integer "D3",           limit: 2
    t.integer "D4",           limit: 2
    t.integer "D5",           limit: 2
    t.integer "D6",           limit: 2
    t.varchar "ModTimeStamp", limit: 14
  end

  create_table "POS_Sales", primary_key: "ID", force: :cascade do |t|
    t.varchar "Product_ID", limit: 15,                           null: false
    t.float   "Quantity",                                        null: false
    t.money   "Amount",                 precision: 19, scale: 4, null: false
    t.date    "Date",                                            null: false
    t.varchar "Notes",      limit: 250
    t.float   "Tax"
  end

  create_table "PO_Details", primary_key: "Transaction_ID", force: :cascade do |t|
    t.string   "PO_ID",             limit: 255,                                                 null: false
    t.string   "Product_ID",        limit: 15,                                                  null: false
    t.integer  "UnitsOnPO",         limit: 4,                                   default: 0,     null: false
    t.money    "UnitPODraftPrice",                     precision: 19, scale: 4
    t.real     "Discount"
    t.boolean  "Reviewed",                                                      default: false, null: false
    t.boolean  "PriceApproved",                                                 default: false, null: false
    t.boolean  "UnitsApproved",                                                 default: false, null: false
    t.boolean  "ReceivedStatus",                                                default: false, null: false
    t.boolean  "Status",                                                                        null: false
    t.text     "Notes",             limit: 2147483647
    t.integer  "UnitsReceived",     limit: 4,                                   default: 0,     null: false
    t.datetime "ReceivingDate"
    t.string   "ReceivedBy",        limit: 255
    t.real     "PriceReceived"
    t.integer  "UnitsPerPackage",   limit: 4
    t.boolean  "Taxable"
    t.float    "UnitsReturned"
    t.datetime "UnitsReturnedDate"
    t.float    "UnitsShrinked"
    t.datetime "UnitsShrinkedDate"
    t.float    "UnitsMissing"
    t.datetime "UnitsMissingDate"
    t.float    "TaxRate",                                                       default: 0.0
    t.datetime "OrderingDate"
    t.string   "OrderedBy",         limit: 255
    t.float    "UnitsOrdered"
    t.float    "PriceOrdered"
    t.integer  "PaidItems",         limit: 4,                                   default: 1,     null: false
    t.integer  "FreeItems",         limit: 4,                                   default: 0,     null: false
    t.float    "SRPRice"
    t.float    "UnitsShipped"
    t.real     "PriceShipped"
    t.boolean  "ShippedStatus",                                                 default: false
    t.datetime "ShippedDate"
    t.string   "ShippedBy",         limit: 50
  end

  create_table "PO_Status", primary_key: "Status_ID", force: :cascade do |t|
    t.string "StatusName", limit: 50
    t.string "Note",       limit: 50
  end

  create_table "POs", primary_key: "PO_ID", force: :cascade do |t|
    t.integer  "Store_ID",           limit: 4
    t.integer  "Buyer_ID",           limit: 4,                                                   null: false
    t.integer  "Supplier_ID",        limit: 4,                                                   null: false
    t.string   "SupplierContact",    limit: 50
    t.datetime "PODraftDate"
    t.string   "PONote",             limit: 255
    t.integer  "POStatus_ID",        limit: 4
    t.boolean  "POComplete",                                                     default: false, null: false
    t.datetime "DeliveryDate"
    t.string   "POReviewer",         limit: 255
    t.string   "POApprover",         limit: 255
    t.datetime "POApprovedDate"
    t.string   "DeliveryTo",         limit: 50
    t.datetime "FirstDeliveryDate"
    t.datetime "LastDeliveryDate"
    t.string   "DeliveryFrequency",  limit: 50
    t.string   "Delivery Name",      limit: 40
    t.string   "Payment Type",       limit: 50
    t.datetime "Paid Date"
    t.money    "Taxes",                                 precision: 19, scale: 4
    t.string   "Tax Status",         limit: 50
    t.text     "Notes",              limit: 2147483647
    t.string   "Invoice",            limit: 50
    t.binary   "Signature",          limit: 2147483647
    t.string   "State",              limit: 255
    t.string   "Ordered_By",         limit: 255
    t.string   "Received_By",        limit: 255
    t.string   "Approved_By",        limit: 255
    t.datetime "Ordering_Date"
    t.datetime "Ordered_Date"
    t.binary   "Ordered_Signature",  limit: 2147483647
    t.datetime "Receiving_Date"
    t.datetime "Received_Date"
    t.binary   "Received_Signature", limit: 2147483647
    t.datetime "Approved_Date"
    t.binary   "Approved_Signature", limit: 2147483647
    t.boolean  "SendToSupplier",                                                 default: false
    t.date     "Invoice_Date"
    t.date     "Shipped_Date"
    t.char     "ShippedToWM",        limit: 1,                                   default: "0"
    t.string   "ShippedBy",          limit: 50
    t.string   "WMInvoice",          limit: 50
  end

  add_index "POs", ["Store_ID", "Supplier_ID", "Invoice"], name: "IX_POs", unique: true

  create_table "PriceGroup", primary_key: "GroupName", force: :cascade do |t|
    t.string  "OnSale",       limit: 1,  default: ""
    t.string  "ModDate",      limit: 10
    t.integer "isQtySale",    limit: 2,  default: 0
    t.integer "QtySaleQty",   limit: 4,  default: 0
    t.float   "QtySalePrice",            default: 1.0
    t.integer "MaxGroupQty",  limit: 2,  default: 0
    t.string  "ModTimeStamp", limit: 14, default: "0"
  end

  create_table "PriceGroupPrice", primary_key: "GroupName", force: :cascade do |t|
    t.string "Grade",       limit: 20,               null: false
    t.float  "RegPrice",               default: 0.0
    t.float  "OnSalePrice",            default: 0.0
    t.float  "BottomPrice",            default: 0.0
  end

  create_table "PriceGroupProd", primary_key: "ProdNum", force: :cascade do |t|
    t.string "GroupName", limit: 20
  end

  create_table "Privileges", primary_key: "Privilege ID", force: :cascade do |t|
    t.string "Privilege Name", limit: 50
  end

  create_table "ProductPrice", primary_key: "ProdNum", force: :cascade do |t|
    t.varchar "Grade",        limit: 20,                          null: false
    t.money   "RegPrice",                precision: 19, scale: 4
    t.money   "BottomPrice",             precision: 19, scale: 4
    t.money   "OnsalePrice",             precision: 19, scale: 4
    t.varchar "ModTimeStamp", limit: 14
    t.string  "Source",       limit: 15
  end

  add_index "ProductPrice", ["ProdNum"], name: "IX_ProductPrice_ProdNum"

  create_table "ProductPrice0", id: false, force: :cascade do |t|
    t.varchar "ProdNum",      limit: 15,                          null: false
    t.varchar "Grade",        limit: 20,                          null: false
    t.money   "RegPrice",                precision: 19, scale: 4
    t.money   "BottomPrice",             precision: 19, scale: 4
    t.money   "OnsalePrice",             precision: 19, scale: 4
    t.varchar "ModTimeStamp", limit: 14
    t.string  "Source",       limit: 15
  end

  create_table "ProductPrice1", id: false, force: :cascade do |t|
    t.varchar "ProdNum",      limit: 15,                          null: false
    t.varchar "Grade",        limit: 20,                          null: false
    t.money   "RegPrice",                precision: 19, scale: 4
    t.money   "BottomPrice",             precision: 19, scale: 4
    t.money   "OnsalePrice",             precision: 19, scale: 4
    t.varchar "ModTimeStamp", limit: 14
    t.string  "Source",       limit: 15
  end

  create_table "ProductPrice_A", primary_key: "ID", force: :cascade do |t|
    t.varchar "ProdNum",      limit: 15,                          null: false
    t.varchar "Grade",        limit: 20,                          null: false
    t.money   "RegPrice",                precision: 19, scale: 4
    t.money   "BottomPrice",             precision: 19, scale: 4
    t.money   "OnsalePrice",             precision: 19, scale: 4
    t.varchar "ModTimeStamp", limit: 14
  end

  create_table "Product_Info", primary_key: "ID", force: :cascade do |t|
    t.string   "Barcode",          limit: 15,                          null: false
    t.varchar  "Name",             limit: 50
    t.string   "Name2",            limit: 40
    t.integer  "Current #",        limit: 4,                           null: false
    t.string   "Department",       limit: 20
    t.varchar  "SPEC",             limit: 20
    t.string   "Rank",             limit: 2
    t.string   "Location",         limit: 32
    t.varchar  "Prod_Desc",        limit: 80
    t.money    "RegPrice",                    precision: 19, scale: 4
    t.money    "OnSale$",                     precision: 19, scale: 4
    t.integer  "OnSales",          limit: 4
    t.integer  "QtySale",          limit: 4
    t.integer  "QtySale#",         limit: 4
    t.float    "QtySale$"
    t.varchar  "Tax",              limit: 3,                           null: false
    t.decimal  "Ordered",                     precision: 8,  scale: 2
    t.decimal  "Lst Rcv $",                   precision: 8,  scale: 2
    t.float    "Lst Rcv #"
    t.integer  "Lst Rcv UPP",      limit: 4
    t.decimal  "Lwst Rcv $",                  precision: 8,  scale: 2
    t.varchar  "LSale Date",       limit: 10,                          null: false
    t.integer  "LSale Day",        limit: 4,                           null: false
    t.varchar  "LInv Date",        limit: 10,                          null: false
    t.float    "Last Wk Sale"
    t.integer  "Supplier_ID",      limit: 4
    t.float    "Quantity"
    t.varchar  "User",             limit: 50
    t.datetime "Time"
    t.varchar  "Lst Rcv Date",     limit: 10
    t.integer  "Lst Rcv Supplier", limit: 4
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

  create_table "ProductsSPEC", primary_key: "ID", force: :cascade do |t|
    t.string "PackageType", limit: 50
    t.string "Size",        limit: 50
    t.string "Made",        limit: 50
  end

  create_table "Products_Pris", primary_key: "Barcode", force: :cascade do |t|
    t.string   "Rank",                limit: 2
    t.string   "Rec_Rank",            limit: 2
    t.string   "User",                limit: 255
    t.string   "Rec_Date",            limit: 255
    t.datetime "ModTime"
    t.float    "InStock"
    t.datetime "InStockDate"
    t.string   "Rank1",               limit: 2
    t.string   "Rank2",               limit: 2
    t.date     "Last_Sale_Date"
    t.date     "Last_Inventory_Date"
    t.string   "Source",              limit: 15
    t.string   "Source_ID",           limit: 15
    t.string   "Second_Name",         limit: 255
    t.string   "Location_Code",       limit: 32
    t.string   "Sub_Category",        limit: 64
    t.string   "Category",            limit: 64
    t.string   "General_Category",    limit: 64
    t.string   "Location_Code2",      limit: 32
    t.char     "CheckDigit",          limit: 1
  end

  create_table "Products_Stores", primary_key: "Prod_Num", force: :cascade do |t|
    t.varchar "Store",       limit: 10
    t.varchar "Prod_Name",   limit: 50
    t.string  "Prod_Alias",  limit: 40
    t.money   "RegPrice",               precision: 19, scale: 4
    t.money   "OnSalePrice",            precision: 19, scale: 4
  end

  create_table "RFgen_ConnCheck", id: false, force: :cascade do |t|
    t.integer "pid", limit: 4
  end

  create_table "Receiving", primary_key: "Receiving_ID", force: :cascade do |t|
    t.string   "PO_ID",                  limit: 255,                                                 null: false
    t.string   "Product_ID",             limit: 15,                                                  null: false
    t.string   "SPEC_Package",           limit: 50
    t.string   "SPEC_Weight",            limit: 50
    t.string   "SPEC_Size",              limit: 50
    t.datetime "ReceivingDate",                                                                      null: false
    t.string   "ReceivedBy",             limit: 50
    t.integer  "UnitsOnPO",              limit: 4
    t.boolean  "UnitsReceivedMatchFlag",                                             default: false, null: false
    t.integer  "UnitsReceived",          limit: 4,                                   default: 0,     null: false
    t.money    "UnitReceivingPrice",                        precision: 19, scale: 4
    t.string   "LocationCode",           limit: 50
    t.text     "Notes",                  limit: 2147483647
    t.real     "UnitsInStock"
    t.real     "UnitsAvailable"
    t.integer  "UnitsInStorage",         limit: 4
    t.real     "UnitsInShelf"
    t.integer  "UnitsSold",              limit: 4
    t.real     "UnitsReturned"
    t.real     "UnitsShrinked"
    t.datetime "BestBeforeDate"
    t.integer  "UnitsLost",              limit: 4
    t.integer  "UnitsTechnicalLost",     limit: 4
    t.boolean  "UnitReceivingStatus",                                                                null: false
  end

  create_table "Sales", primary_key: "ID", force: :cascade do |t|
    t.integer  "Store_ID",     limit: 4
    t.string   "Product_ID",   limit: 255
    t.datetime "SumStartDate"
    t.datetime "SumEndDate"
    t.integer  "SaleQuantity", limit: 4
    t.money    "SaleAvgPrice",             precision: 19, scale: 4
  end

  create_table "Storage", primary_key: "Storage_ID", force: :cascade do |t|
    t.integer  "Store_ID",      limit: 4
    t.varchar  "Product_ID",    limit: 15
    t.string   "StoragedBy",    limit: 50
    t.datetime "StoragedDate"
    t.string   "Location",      limit: 50
    t.float    "Units"
    t.text     "Notes",         limit: 2147483647
    t.nchar    "InspectedBy",   limit: 10
    t.datetime "InspectedDate"
    t.boolean  "Active",                           default: true, null: false
    t.boolean  "LocationOnly",                     default: true, null: false
  end

  create_table "Stores", primary_key: "Store_ID", force: :cascade do |t|
    t.string  "StoreName",     limit: 40,             null: false
    t.string  "ContactName",   limit: 30
    t.string  "ContactTitle",  limit: 30
    t.string  "Address",       limit: 60
    t.string  "City",          limit: 15
    t.string  "Region",        limit: 15
    t.string  "PostalCode",    limit: 10
    t.string  "Country",       limit: 15
    t.string  "Phone",         limit: 24
    t.string  "Fax",           limit: 24
    t.integer "BusinessNo",    limit: 4
    t.integer "NextPOID",      limit: 4,  default: 1, null: false
    t.string  "StoreFullName", limit: 40
    t.integer "NextBATCHID",   limit: 4
    t.varchar "Active",        limit: 2
  end

  create_table "SubCategories", id: false, force: :cascade do |t|
    t.string "Sub_CategoryID",  limit: 4
    t.string "Category_ID",     limit: 2
    t.string "Sub_Category",    limit: 50
    t.string "Sub_Cat_Chinese", limit: 50
  end

  create_table "Supplier_Products", id: false, force: :cascade do |t|
    t.string  "Product_ID",  limit: 15, null: false
    t.integer "Supplier_ID", limit: 4,  null: false
  end

  create_table "Suppliers", primary_key: "Supplier_ID", force: :cascade do |t|
    t.integer "Payment Supplier_ID", limit: 4
    t.string  "CompanyName",         limit: 255
    t.string  "Tel",                 limit: 255
    t.string  "Fax",                 limit: 255
    t.string  "Email",               limit: 255
    t.string  "Addr",                limit: 255
    t.string  "Post Code",           limit: 255
  end

  create_table "Suppliers_2015_08_29", primary_key: "Supplier_ID", force: :cascade do |t|
    t.string  "CompanyName",    limit: 50,  null: false
    t.string  "ContactName",    limit: 30
    t.string  "ContactTitle",   limit: 30
    t.string  "Address",        limit: 60
    t.string  "City",           limit: 15
    t.string  "Region",         limit: 15
    t.string  "PostalCode",     limit: 10
    t.string  "Country",        limit: 15
    t.string  "Phone",          limit: 24
    t.string  "Fax",            limit: 24
    t.string  "HomePage",       limit: 255
    t.integer "DiscountRate",   limit: 4
    t.string  "CellNumber",     limit: 50
    t.string  "GSTNumber",      limit: 50
    t.string  "E_Mail_Address", limit: 255
    t.integer "Buyer_ID",       limit: 4
  end

  create_table "Temp1", id: false, force: :cascade do |t|
    t.varchar  "Product_ID",        limit: 15
    t.datetime "LastInspectedDate"
    t.integer  "Inspected_Units",   limit: 4,  null: false
    t.integer  "Sold_Units",        limit: 4,  null: false
    t.integer  "Loss_Units",        limit: 4,  null: false
    t.integer  "Receiving_Units",   limit: 4,  null: false
  end

  create_table "Temp_Summary", id: false, force: :cascade do |t|
    t.varchar "Product_ID",      limit: 15, null: false
    t.date    "D1"
    t.date    "D2"
    t.float   "Sold_Units",                 null: false
    t.float   "Sold_Amount",                null: false
    t.float   "Sold_Tax",                   null: false
    t.float   "Loss_Units",                 null: false
    t.float   "Receiving_Units",            null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,          default: 0, null: false
    t.integer  "attempts",   limit: 4,          default: 0, null: false
    t.text     "handler",    limit: 2147483647,             null: false
    t.text     "last_error", limit: 2147483647
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 4000
    t.string   "queue",      limit: 4000
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "departments", force: :cascade do |t|
    t.string   "name",       limit: 32
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "employees_2015_08_30", primary_key: "ID", force: :cascade do |t|
    t.integer "Store_ID",       limit: 4
    t.string  "Last Name",      limit: 50
    t.string  "First Name",     limit: 50
    t.string  "E-mail Address", limit: 50
    t.string  "Job Title",      limit: 50
    t.string  "Business Phone", limit: 25
    t.string  "Home Phone",     limit: 25
    t.string  "Mobile Phone",   limit: 25
    t.string  "Fax Number",     limit: 25
    t.text    "Address",        limit: 2147483647
    t.string  "City",           limit: 50
    t.string  "Province",       limit: 50
    t.string  "Postal Code",    limit: 15
    t.text    "Notes",          limit: 2147483647
    t.text    "Attachments",    limit: 2147483647
    t.string  "Password",       limit: 32
  end

  create_table "itemchangelog", primary_key: "ID", force: :cascade do |t|
    t.varchar "Prod_Num",         limit: 15,                                           null: false
    t.string  "Department",       limit: 20
    t.string  "General_Category", limit: 64
    t.string  "Category",         limit: 64
    t.string  "Sub_Category",     limit: 64
    t.varchar "Prod_Name",        limit: 50
    t.string  "Prod_Alias",       limit: 40
    t.string  "Second_Name",      limit: 255
    t.varchar "PackageSpec",      limit: 20
    t.varchar "Prod_Desc",        limit: 80
    t.varchar "Measure",          limit: 50
    t.varchar "ModTimeStamp",     limit: 14
    t.integer "OnSales",          limit: 4
    t.integer "Tax1App",          limit: 2
    t.integer "Tax2App",          limit: 2
    t.integer "QtySale",          limit: 4
    t.integer "QtySaleQty",       limit: 4
    t.float   "QtySalePrice"
    t.money   "RegPrice",                     precision: 19, scale: 4
    t.money   "OnsalePrice",                  precision: 19, scale: 4
    t.string  "ChangedBy",        limit: 255
    t.boolean "SendToWM",                                              default: false, null: false
    t.varchar "PriceGroupName",   limit: 25
    t.integer "PriceMode",        limit: 4
    t.integer "scaletray",        limit: 4
    t.integer "inactive",         limit: 4
    t.varchar "qtygroup",         limit: 25
    t.float   "maxbuyqty"
    t.float   "maxonsaleqty"
    t.integer "isfood",           limit: 2
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
    t.string   "name",       limit: 4000
    t.string   "job_type",   limit: 4000
    t.string   "input",      limit: 4000
    t.string   "output",     limit: 4000
    t.string   "state",      limit: 4000
    t.string   "stdout",     limit: 4000
    t.string   "stderr",     limit: 4000
    t.datetime "start"
    t.datetime "finish"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string   "product_id",       limit: 15,                                               null: false
    t.integer  "store_id",         limit: 4,                                                null: false
    t.integer  "employee_id",      limit: 4,                                                null: false
    t.real     "quantity",                                                                  null: false
    t.string   "state",            limit: 255,                         default: "ordering", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "supplier_id",      limit: 4
    t.integer  "UnitsPerPackage",  limit: 4
    t.varchar  "Lst_Rcv_Date",     limit: 10
    t.integer  "Lst_Rcv_Supplier", limit: 4
    t.decimal  "Lst_Rcv_Price",                precision: 8, scale: 2
    t.float    "Lst_Rcv_Quantity"
    t.decimal  "Lwst_Rcv_Price",               precision: 8, scale: 2
  end

  create_table "scan_logs", primary_key: "ID", force: :cascade do |t|
    t.string   "Barcode",            limit: 15, null: false
    t.string   "Normalized_Barcode", limit: 15, null: false
    t.datetime "Created_At",                    null: false
  end

  create_table "sysdiagrams", primary_key: "diagram_id", force: :cascade do |t|
    t.string  "name",         limit: 128,        null: false
    t.integer "principal_id", limit: 4,          null: false
    t.integer "version",      limit: 4
    t.binary  "definition",   limit: 2147483647
  end

  add_index "sysdiagrams", ["principal_id", "name"], name: "UK_principal_name", unique: true

  create_table "t_ConfirmedChange", primary_key: "Prod_Num", force: :cascade do |t|
    t.string  "Department",       limit: 20
    t.string  "General_Category", limit: 64
    t.string  "Category",         limit: 64
    t.string  "Sub_Category",     limit: 64
    t.varchar "Prod_Name",        limit: 50
    t.string  "Prod_Alias",       limit: 40
    t.string  "Second_Name",      limit: 255
    t.varchar "PackageSpec",      limit: 20
    t.varchar "Prod_Desc",        limit: 80
    t.varchar "Measure",          limit: 50
    t.varchar "ModTimeStamp",     limit: 14
    t.integer "OnSales",          limit: 4
    t.integer "Tax1App",          limit: 2
    t.integer "Tax2App",          limit: 2
    t.integer "QtySale",          limit: 4
    t.integer "QtySaleQty",       limit: 4
    t.float   "QtySalePrice"
    t.money   "RegPrice",                     precision: 19, scale: 4
    t.money   "OnsalePrice",                  precision: 19, scale: 4
    t.string  "ChangedBy",        limit: 255
    t.boolean "SendToWM",                                              default: false, null: false
    t.varchar "PriceGroupName",   limit: 25
    t.integer "PriceMode",        limit: 4
    t.integer "scaletray",        limit: 4
    t.integer "inactive",         limit: 4
    t.varchar "qtygroup",         limit: 25
    t.float   "maxbuyqty"
    t.float   "maxonsaleqty"
    t.integer "isfood",           limit: 2
  end

  create_table "t_LocationProducts", id: false, force: :cascade do |t|
    t.string "Barcode", limit: 20, null: false
  end

  create_table "t_POList", id: false, force: :cascade do |t|
    t.string "Product_ID", limit: 15, null: false
  end

  create_table "t_ProdList", id: false, force: :cascade do |t|
    t.varchar "Product_ID", limit: 15, null: false
  end

  create_table "t_Suppliers_Products", id: false, force: :cascade do |t|
    t.integer "Supplier_ID", limit: 4
    t.varchar "Product_ID",  limit: 25
  end

  create_table "t_Temp1", id: false, force: :cascade do |t|
    t.varchar "Prod_Num",               limit: 15, null: false
    t.varchar "Name",                   limit: 50
    t.string  "Second_Name",            limit: 40
    t.string  "Department",             limit: 20
    t.varchar "Spec",                   limit: 20
    t.varchar "Measure",                limit: 50
    t.varchar "Origin",                 limit: 80
    t.varchar "Reg_Price",              limit: 8
    t.varchar "OnSale_Price",           limit: 8
    t.char    "OnSale_Start",           limit: 10
    t.char    "OnSale_End",             limit: 10
    t.varchar "Tax",                    limit: 5
    t.varchar "Quantity_Sale_Quantity", limit: 5
    t.varchar "Quantity_Sale_Price",    limit: 8
    t.string  "Location_Code",          limit: 32
    t.varchar "Misc_1",                 limit: 32
    t.varchar "Misc_2",                 limit: 32
    t.varchar "Misc_3",                 limit: 32
    t.varchar "Misc_4",                 limit: 32
    t.float   "MaxBuyQty"
    t.float   "MaxOnSaleQty"
    t.string  "Location_code2",         limit: 32
  end

  create_table "t_Temp2", id: false, force: :cascade do |t|
    t.string  "Product_ID",  limit: 15,  null: false
    t.string  "PO_ID",       limit: 255, null: false
    t.integer "Supplier_ID", limit: 4,   null: false
  end

  create_table "tblPOS", primary_key: "ID", force: :cascade do |t|
    t.integer  "Store_ID",     limit: 4
    t.integer  "Sales_ID",     limit: 4
    t.string   "Product_ID",   limit: 255
    t.datetime "SalesDate"
    t.integer  "SaleQuantity", limit: 4
    t.money    "SalePrice",                precision: 19, scale: 4
  end

  create_table "tss_employees", id: false, force: :cascade do |t|
    t.integer  "id",         limit: 4,   default: 0,          null: false
    t.integer  "store_id",   limit: 4
    t.string   "empno",      limit: 255
    t.string   "barcode",    limit: 255
    t.string   "name",       limit: 255
    t.string   "name_cn",    limit: 255
    t.string   "department", limit: 255
    t.string   "position",   limit: 255, default: "Employee"
    t.integer  "manager_id", limit: 4
    t.integer  "active",     limit: 1,   default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
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
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

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

  create_table "ws_inventory", id: false, force: :cascade do |t|
    t.string "ProductID",    limit: 50, null: false
    t.string "LocationCode", limit: 50, null: false
    t.float  "Inventory"
  end

  add_foreign_key "Employee Privileges", "Privileges", column: "Privilege ID", primary_key: "Privilege ID", name: "FK_Employee Privileges_Privileges"
  add_foreign_key "POs", "Employees", column: "Buyer_ID", primary_key: "ID", name: "FK_POs_Employees"
  add_foreign_key "POs", "PO_Status", column: "POStatus_ID", primary_key: "Status_ID", name: "FK_POs_PO_Status"
  add_foreign_key "POs", "Stores", column: "Store_ID", primary_key: "Store_ID", name: "FK_POs_Stores"
  add_foreign_key "POs", "Suppliers", column: "Supplier_ID", primary_key: "Supplier_ID", name: "FK_POs_Suppliers"
  add_foreign_key "Receiving", "PO_Details", column: "PO_ID", primary_key: "PO_ID", name: "FK_Receiving_PO_Details"
  add_foreign_key "Receiving", "PO_Details", column: "Product_ID", primary_key: "Product_ID", name: "FK_Receiving_PO_Details"
end
