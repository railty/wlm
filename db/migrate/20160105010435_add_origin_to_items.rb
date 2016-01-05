class AddOriginToItems < ActiveRecord::Migration
  def change
    #add_column :items, :origin, :string, :limit => 2
    add_column :items, :origin, "char(2)"
    add_column :items, :proposed_price, :decimal, :precision=>6, :scale=>2
    add_column :items, :state, :string
    add_column :items, :notes, :string
  end
end
