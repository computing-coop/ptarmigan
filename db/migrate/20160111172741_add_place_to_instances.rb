class AddPlaceToInstances < ActiveRecord::Migration
  def change
    add_column :instances, :place_id, :integer
  end
end
