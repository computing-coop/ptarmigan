class AddStuffToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :latitude, :double
    add_column :places, :longitude, :double
    add_column :places, :approved_for_posters, :boolean
    add_column :places, :allow_ptarmigan_events, :boolean
    execute("update places set allow_ptarmigan_events = true where id not in (1, 2, 26, 27)")
  end
end
