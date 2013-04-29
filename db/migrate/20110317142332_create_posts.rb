# -*- encoding : utf-8 -*-
class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.references :user, :null => false
      t.references :location, :null => false
      t.boolean :published, :null => false, :default => false
      t.boolean :is_personal, :null => false, :default => false
      t.timestamps
    end
    Post.create_translation_table! :title => :string, :body => :text
  end

  def self.down
    drop_table :posts
    Post.drop_translation_table!
  end
end
