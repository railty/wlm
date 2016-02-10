class CreateWmItems < ActiveRecord::Migration
  def change
    create_table :wm_items, id: false do |t|
      t.integer :Acct_Dept_Nbr
      t.string :Dept_Desc
      t.string :UPC, :limit => 13
      t.string :VNPK_UPC, :limit => 13
      t.decimal :Unit_Retail, :precision=>6, :scale=>2
      t.decimal :Unit_Cost, :precision=>6, :scale=>2
      t.decimal :Unit_Size
      t.string :Unit_Size_UOM
      t.string :Signing_Desc
      t.decimal :VNPK_Qty
      t.integer :Item_Nbr, null: false
      t.string :Item_Flags
      t.string :Item_Desc_1
      t.string :Vendor_Stk_Nbr
      t.string :Size_Desc
      t.integer :Fineline_Number
      t.string :Fineline_Description
      t.decimal :VNPK_Cost, :precision=>6, :scale=>2
      t.string :Item_Status
      t.string :Item_Type
      t.date :Effective_Date
      t.date :Create_Date

      t.string :Source
    end

    reversible do |dir|
      dir.up do
        execute <<-SQL
          ALTER TABLE wm_items ADD CONSTRAINT wm_items_pk PRIMARY KEY (Item_Nbr)
        SQL
      end
      dir.down do
        execute <<-SQL
          ALTER TABLE wm_items DROP CONSTRAINT wm_items_pk
        SQL
      end
    end
  end
end
