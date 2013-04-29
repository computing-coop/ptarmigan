# -*- encoding : utf-8 -*-
class CreateChatters < ActiveRecord::Migration
  def self.up
    create_table :chatters do |t|
      t.string :subject
      t.references :user
      t.text :body
      t.string :image_file_name
      t.integer :image_file_size
      t.string :image_content_type
      t.datetime :image_updated_at
      t.timestamps
    end
  end

  def self.down
    drop_table :chatters
  end
end
