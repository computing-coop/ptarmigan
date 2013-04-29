# -*- encoding : utf-8 -*-
class AddPlaceToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :place_id, :integer, :null => false, :default => 1

  end

  def self.down
    remove_column :events, :place_id
  end
end
