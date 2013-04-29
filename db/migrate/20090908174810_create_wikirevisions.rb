# -*- encoding : utf-8 -*-
class CreateWikirevisions < ActiveRecord::Migration
  def self.up
    create_table :wikirevisions do |t|
      t.references :user
      t.text :contents
      t.references :wikipage
      
      t.timestamps
    end
    
    add_index :wikirevisions, :wikipage_id
  end
  
  def self.down
    drop_table :wikirevisions
  end
end
