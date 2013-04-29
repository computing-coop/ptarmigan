# -*- encoding : utf-8 -*-
class CreatePlaces < ActiveRecord::Migration
  def self.up
    create_table :places do |t|
      t.string :name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :country
      t.string :postcode
      t.string :map_url

      t.timestamps
    end
  end

  def self.down
    drop_table :places
  end
end
