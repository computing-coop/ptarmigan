# -*- encoding : utf-8 -*-
class AddProjectToProposals < ActiveRecord::Migration
  def self.up
    add_column :proposals, :project_id, :integer, :null => true
    add_column :projects, :proposable, :boolean, :null => false, :default => false
    add_column :projects, :hidden, :boolean, :null => false, :default => false
  end

  def self.down
    remove_column :proposals, :project_id
    remove_column :projects, :proposable
    remove_column :projects, :hidden
  end
end
