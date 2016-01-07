class CreateLocationsUsers < ActiveRecord::Migration
  def change
    create_join_table :locations, :users
  end
end
