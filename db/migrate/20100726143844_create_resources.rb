# -*- encoding : utf-8 -*-
class CreateResources < ActiveRecord::Migration
  def self.up
    create_table :resources do |t|
      t.string :name
      t.text :description
      t.references :project
      t.references :artist
      t.references :event
      t.string :icon_file_name
      t.integer :icon_file_size
      t.string :icon_content_type
      t.datetime :icon_updated_at
      t.string :attachment_file_name
      t.integer :attachment_file_size
      t.string :attachment_content_type
      t.datetime :attachment_updated_at
      
      t.timestamps
    end
  end
  
  def self.down
    drop_table :resources
  end
end
