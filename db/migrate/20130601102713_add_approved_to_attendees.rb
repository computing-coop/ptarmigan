class AddApprovedToAttendees < ActiveRecord::Migration
  def change
    add_column :attendees, :approved, :boolean
    add_column :events, :require_approval, :boolean, :default => false, :null => false
  end
end
