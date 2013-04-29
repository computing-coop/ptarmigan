# -*- encoding : utf-8 -*-
class AddPublicschoolToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :publicschool, :integer
  end

  def self.down
    remove_column :events, :publicschool
  end
end
