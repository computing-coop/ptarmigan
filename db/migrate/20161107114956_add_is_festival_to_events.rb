class AddIsFestivalToEvents < ActiveRecord::Migration[5.0]
  def change
    execute("update events set enddate = null where enddate = '0000-00-00 00:00:00'")
    add_column :events, :is_festival, :boolean
  end
end
