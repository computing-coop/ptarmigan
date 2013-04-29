# -*- encoding : utf-8 -*-
class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos do |t|
      t.references :videohost, :null => false
      t.references :event, :null => false
      t.string :creator
      t.integer :hostid, :limit => 8
      t.string :name, :null => false
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :videos
  end
end
