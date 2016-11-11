class AddCreativequartersToPlaces < ActiveRecord::Migration[5.0]
  def change
    add_column :places, :creative_quarters, :boolean, null: false, default: false
  end
end
