# -*- encoding : utf-8 -*-
class CreateCashes < ActiveRecord::Migration
  def self.up
    create_table :cashes do |t|
      t.string :source
      t.string :title
      t.string :link_url
      t.text :content
      t.integer :order

      t.timestamps
    end
  end

  def self.down
    drop_table :cashes
  end
end
