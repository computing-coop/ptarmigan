# -*- encoding : utf-8 -*-
class CreatePresslinks < ActiveRecord::Migration
  def self.up
    create_table :presslinks do |t|
      t.references :location
      t.references :project
      t.references :event
      t.references :artist
      t.boolean :all_locations
      t.string :title
      t.text :description
      t.text :url
      t.date :when
      t.float :sortorder
      t.string :source

      t.timestamps
    end
  end

  def self.down
    drop_table :presslinks
  end
end
