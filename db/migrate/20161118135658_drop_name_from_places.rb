class DropNameFromPlaces < ActiveRecord::Migration[5.0]
  def change
    remove_column :places, :name
  end
end
