class CreateAlbumImages < ActiveRecord::Migration
  def change
    create_table :album_images do |t|
      t.integer :album_id
      t.string :image
      t.string  :image_file_name
      t.string   :image_content_type
      t.integer  :image_file_size
      t.timestamps
    end
  end
end
