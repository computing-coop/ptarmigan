class CreateCarouselvideos < ActiveRecord::Migration[5.0]
  def self.up
    create_table :carouselvideos do |t|
      t.integer :location_id
      t.integer :subsite_id
      t.boolean :published
      t.string :video_url
      t.integer :video_height
      t.integer :video_width
      t.string :stillimage_file_name
      t.integer :stillimage_file_size, length: 8
      t.string :stillimage_content_type
      t.datetime :stillimage_updated_at
      t.string :link_url
      t.timestamps
    end
    Carouselvideo.create_translation_table! title: :string, subtitle: :string
  end
  
  def self.down
    drop_table :carouselvideos
    Carouselvideo.drop_translation_table!
  end
  
end
