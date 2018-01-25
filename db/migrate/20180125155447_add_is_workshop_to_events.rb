class AddIsWorkshopToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :is_workshop, :boolean, default: false, null: false
  end
end
