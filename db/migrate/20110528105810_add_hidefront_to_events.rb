# -*- encoding : utf-8 -*-
class AddHidefrontToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :featured, :boolean, :default => false, :null => false
    add_column :events, :hide_from_front, :boolean, :default => false, :null => false
  end

  def self.down
    drop_column :events, :featured
    drop_column :events, :hide_from_front
  end
end
