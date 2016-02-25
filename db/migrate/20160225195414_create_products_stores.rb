class CreateProductsStores < ActiveRecord::Migration
  def change
    create_table :products_stores, primary_key: "Prod_Num" do |t|
      t.string "Store",       limit: 10
      t.string "Prod_Name",   limit: 50
      t.string "Prod_Alias",  limit: 40
      t.decimal "RegPrice", :precision=>6, :scale=>2
      t.decimal "OnSalePrice",:precision=>6, :scale=>2
    end
  end
end
