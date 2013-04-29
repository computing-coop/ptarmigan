# -*- encoding : utf-8 -*-
class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name, :null => false
      t.string :website1
      t.string :website2
      t.text :description_fi
      t.text :description_en
      t.string :avatar_file_name
      t.integer :avatar_file_size
      t.string :avatar_content_type
      t.datetime :avatar_updated_at
      t.boolean :active, :default => true, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
