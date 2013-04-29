# -*- encoding : utf-8 -*-
class AddArtistToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :artist_id, :integer
    add_column :events, :public, :boolean
    execute %{UPDATE events SET public = true;} 
  end

  def self.down
    remove_column :events, :public
    remove_column :events, :artist_id
  end
end
