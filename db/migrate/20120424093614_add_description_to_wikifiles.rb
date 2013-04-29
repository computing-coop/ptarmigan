# -*- encoding : utf-8 -*-
class AddDescriptionToWikifiles < ActiveRecord::Migration
  def self.up
    add_column :wikifiles, :description, :text
  end

  def self.down
    remove_column :wikifiles, :description
  end
end
