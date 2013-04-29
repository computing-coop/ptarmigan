# -*- encoding : utf-8 -*-
class AddEnddateToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :enddate, :date
    add_column :events, :discountedcost, :float
    add_column :events, :project_id, :integer
    add_column :events, :discountreason, :string
  end

  def self.down
    remove_column :events, :discountreason
    remove_column :events, :project_id
    remove_column :events, :discountedcost
    remove_column :events, :enddate
  end
end
