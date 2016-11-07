class AddIsFestivalToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :is_festival, :boolean
  end
end
