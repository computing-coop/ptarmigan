class AddShowguestlistToEvents < ActiveRecord::Migration
  def change
    add_column :events, :show_guests_to_public, :boolean, :default => false, :null => false
  end
end
