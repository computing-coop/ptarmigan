# -*- encoding : utf-8 -*-
class AddShowedupToAttendees < ActiveRecord::Migration
  def self.up
    add_column :attendees, :showed_up, :boolean
    add_column :attendees, :waiting_list, :boolean, :default => false
    execute("update attendees set showed_up=true")
  end

  def self.down
    remove_column :attendees, :showed_up
    remove_column :attendees, :waiting_list
  end
end
