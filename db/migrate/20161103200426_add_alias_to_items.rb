class AddAliasToItems < ActiveRecord::Migration
  def change
    add_column :items, :alias, :string
  end
end
