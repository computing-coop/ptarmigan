class AddInvitedToAttendees < ActiveRecord::Migration
  def change
    add_column :attendees, :invited, :boolean
  end
end
