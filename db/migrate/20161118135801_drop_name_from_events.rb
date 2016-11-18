class DropNameFromEvents < ActiveRecord::Migration[5.0]
  def change
    remove_column :events, :notes
    remove_column :events, :description
  end
end
