# -*- encoding : utf-8 -*-
class AddPresspageToResources < ActiveRecord::Migration
  def self.up
    add_column :resources, :press_page, :boolean
    add_column :resources, :location_id, :integer
    add_column :resources, :all_locations, :boolean
  end

  def self.down
    remove_column :resources, :all_locations
    remove_column :resources, :location_id
    remove_column :resources, :press_page
  end
end
