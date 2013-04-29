# -*- encoding : utf-8 -*-
class AddDonationsToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :donations_requested, :boolean, :default => false, :null => false
  end

  def self.down
    remove_column :events, :donations_requested
  end
end
