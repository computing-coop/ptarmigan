class AddProjectorganisationToAttendees < ActiveRecord::Migration
  def change
    add_column :attendees, :project_or_organisation, :string
  end
end
