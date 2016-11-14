class AddNestedToPlaces < ActiveRecord::Migration[5.0]
  def change
    add_column :places, :lft, :integer, null: false, index: true
    add_column :places, :rgt, :integer, null: false, index: true
    add_column :places, :parent_id, :integer, null: true, index: true
  end
end
