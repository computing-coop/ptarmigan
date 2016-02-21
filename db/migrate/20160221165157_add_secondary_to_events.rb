class AddSecondaryToEvents < ActiveRecord::Migration
  def change
    add_column :events, :secondary, :boolean, default: false, null: false
  end
end
