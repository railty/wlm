class CreateAlpItems < ActiveRecord::Migration
  def change
    create_table :alp_items do |t|
      t.references :store
      t.string :code
      t.string :name
      t.string :alias
      t.string :description
      t.string :package_spec
      t.string :department
      t.decimal :price, :precision=>6, :scale=>2
      t.decimal :sale_price, :precision=>6, :scale=>2
      t.boolean :onsale, :default=>false
      t.timestamps null: false
    end
  end
end
