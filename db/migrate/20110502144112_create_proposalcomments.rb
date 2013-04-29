# -*- encoding : utf-8 -*-
class CreateProposalcomments < ActiveRecord::Migration
  def self.up
    create_table :proposalcomments do |t|
      t.references :user, :null => false
      t.references :proposal, :null => false
      t.text :comment
      t.timestamps
    end
  end

  def self.down
    drop_table :proposalcomments
  end
end
