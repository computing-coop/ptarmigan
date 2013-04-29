# -*- encoding : utf-8 -*-
class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string :name
      t.string :international_name
      t.string :locale, :limit => 2

      t.timestamps
    end
    execute('insert into locations (name, international_name, locale) values ("Suomi", "Finland", "fi")')
    execute('insert into locations (name, international_name, locale) values ("Eesti", "Estonia", "ee")')
    add_column :artists, :location_id, :integer, {:null => false, :default => 1}
    add_column :projects, :location_id, :integer, {:null => false, :default => 1}
    add_column :events, :location_id, :integer, {:null => false, :default => 1}
    add_column :pages, :location_id, :integer, {:null => false, :default => 1}
  end

  def self.down
    drop_table :locations
  end
end
