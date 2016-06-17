class AddChangedAtToAlpItems < ActiveRecord::Migration
  def change
    add_column :alp_items, :changed_at, :timestamp
  end
end
