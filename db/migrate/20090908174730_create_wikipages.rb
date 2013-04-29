# -*- encoding : utf-8 -*-
class CreateWikipages < ActiveRecord::Migration
  def self.up
    create_table :wikipages do |t|
      t.string :title
      
      t.timestamps
    end
  end
  
  def self.down
    drop_table :wikipages
  end
end
