# -*- encoding : utf-8 -*-
class AddIsvideoToFlickers < ActiveRecord::Migration
  def self.up
    add_column :flickers, :is_video, :boolean
  end

  def self.down
    remove_column :flickers, :is_video
  end
end
