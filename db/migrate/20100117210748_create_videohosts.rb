# -*- encoding : utf-8 -*-
class CreateVideohosts < ActiveRecord::Migration
  def self.up
    create_table :videohosts do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :videohosts
  end
end
