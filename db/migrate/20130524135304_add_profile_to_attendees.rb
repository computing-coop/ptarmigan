class AddProfileToAttendees < ActiveRecord::Migration
  def change
    add_column :attendees, :profile_file_name, :string
    add_column :attendees, :profile_file_size, :integer
    add_column :attendees, :profile_content_type, :string
    add_column :attendees, :profile_updated_at, :datetime
    add_column :attendees, :bio, :text
    add_column :attendees, :filmstill_file_name, :string
    add_column :attendees, :filmstill_file_size, :integer
    add_column :attendees, :filmstill_content_type, :string
    add_column :attendees, :filmstill_updated_at, :datetime
  end
end
