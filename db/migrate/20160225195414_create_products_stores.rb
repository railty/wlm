class CreateProductsStores < ActiveRecord::Migration
  def change
    create_table :products_stores, id: false do |t|
      t.string "Store",       limit: 10
      t.string "Prod_Num",    limit: 15, null: false
      t.string "Prod_Name",   limit: 50
      t.string "Prod_Alias",  limit: 40
      t.decimal "RegPrice", :precision=>6, :scale=>2
      t.decimal "OnSalePrice",:precision=>6, :scale=>2
    end

    reversible do |dir|
      dir.up do
        execute <<-SQL
          ALTER TABLE products_stores ADD CONSTRAINT products_stores_pk PRIMARY KEY (Prod_Num)
        SQL
      end
      dir.down do
        execute <<-SQL
          ALTER TABLE products_stores DROP CONSTRAINT products_stores_pk
        SQL
      end
    end
  end
end
