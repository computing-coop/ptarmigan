# -*- encoding : utf-8 -*-
class AddSortorderToResources < ActiveRecord::Migration
  def self.up
    add_column :resources, :sortorder, :float
  end

  def self.down
    remove_column :resources, :sortorder
  end
end
