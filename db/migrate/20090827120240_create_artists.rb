# -*- encoding : utf-8 -*-
class CreateArtists < ActiveRecord::Migration
  def self.up
    create_table :artists do |t|
      t.date :startdate
      t.date :enddate
      t.string :name
      t.string :country
      t.string :website1
      t.string :website2
      t.text :bio_fi
      t.text :bio_en
      t.string :avatar_file_name
      t.string :avatar_content_type
      t.integer :avatar_file_size
      t.datetime :avatar_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :artists
  end
end
