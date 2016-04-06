class AddTimestampToWmItems < ActiveRecord::Migration
  def change
    add_timestamps :wm_items
  end
end
