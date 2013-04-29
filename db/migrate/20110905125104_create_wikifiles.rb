# -*- encoding : utf-8 -*-
class CreateWikifiles < ActiveRecord::Migration
  def self.up
    create_table :wikifiles do |t|
      t.references :wikirevision
      t.string :attachment_file_name
      t.string :attachment_content_type
      t.integer :attachment_file_size
      t.datetime :attachment_updated_at
      t.timestamps
    end
  end

  def self.down
    drop_table :wikifiles
  end
end
