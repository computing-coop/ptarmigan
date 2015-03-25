class CreateEventsEventcategories < ActiveRecord::Migration
  def up
    create_table :eventcategories_events, :id => false do |t|
      t.references :event, :null => false
      t.references :eventcategory, :null => false
    end
    add_index(:eventcategories_events, [:event_id, :eventcategory_id], :unique => true)
  end

  def down
    drop_table :eventcategories_events
  end
end
