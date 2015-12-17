class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :department_id
      t.string :upc, :limit => 13
      t.string :vnpk_upc, :limit => 13
      t.decimal :unit_retail, :precision=>6, :scale=>2
      t.decimal :unit_cost, :precision=>6, :scale=>2
      t.decimal :unit_size
      t.string :unit_size_uom
      t.string :signing_desc
      t.decimal :vnpk_qty
      t.string :item_flags
      t.string :item_desc_1
      t.string :vendor_stk_nbr
      t.string :size_desc
      t.decimal :fineline_number
      t.string :fineline_description
      t.timestamps null: false
    end
  end
end
