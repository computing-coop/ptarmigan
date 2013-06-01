
class AddComesfromToAttendees < ActiveRecord::Migration
  def change
    add_column :attendees, :comes_from, :string
    add_column :attendees, :work_in_progress_title, :string
  end
end
