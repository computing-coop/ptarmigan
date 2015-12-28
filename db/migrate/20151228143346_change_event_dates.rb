class ChangeEventDates < ActiveRecord::Migration
  def change
    change_column :events, :date, :datetime
    change_column :events, :enddate, :datetime
  end
end
