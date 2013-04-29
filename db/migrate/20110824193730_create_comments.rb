# -*- encoding : utf-8 -*-
class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.references :user
      t.references :chatter
      t.text :body
      t.string :image_file_name
      t.integer :image_file_size
      t.string :image_content_type
      t.datetime :image_updated_at
      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
