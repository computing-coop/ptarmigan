# -*- encoding : utf-8 -*-
class AddFacebookToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :facebook, :bigint
  end

  def self.down
    remove_column :events, :facebook
  end
end
