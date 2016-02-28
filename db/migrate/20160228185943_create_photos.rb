class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :item
      t.string :photo_type

      t.timestamps null: false
    end
  end
end
