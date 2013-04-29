# -*- encoding : utf-8 -*-
class AddMenuizeToWikipages < ActiveRecord::Migration
  def self.up
    add_column :wikipages, :menuize, :boolean
    add_column :chatters, :menuize, :boolean
    add_column :proposals, :menuize, :boolean
    add_column :proposals, :archived, :boolean    
  end

  def self.down
    remove_column :wikipages, :menuize
    remove_column :chatters, :menuize
    remove_column :proposals, :menuize    
    remove_column :proposals, :archived       
  end
end
