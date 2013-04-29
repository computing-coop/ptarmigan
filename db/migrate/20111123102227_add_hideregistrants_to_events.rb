# -*- encoding : utf-8 -*-
class AddHideregistrantsToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :hide_registrants, :boolean, :null => false, :default => false
  end

  def self.down
    remove_column :events, :hide_registrants
  end
end
