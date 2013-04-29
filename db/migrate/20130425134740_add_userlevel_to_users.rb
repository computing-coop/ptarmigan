class AddUserlevelToUsers < ActiveRecord::Migration
  def change
    add_column :users, :userlevel, :integer, :default => 1, :null => false
    execute("update users set userlevel=3 where id in (1, 3, 4, 5, 7, 8, 9, 11)")
  end
end
