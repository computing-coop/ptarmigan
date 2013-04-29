# -*- encoding : utf-8 -*-
class CreateFlickers < ActiveRecord::Migration
  def self.up
    create_table :flickers do |t|
      t.references :event, :null => false
      t.string :creator, :null => false
      t.integer :hostid, :limit => 8,  :null => false
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :flickers
  end
end
