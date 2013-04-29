# -*- encoding : utf-8 -*-
class AddStuffToApplicants < ActiveRecord::Migration
  def self.up
    add_column :applicants, :address, :text, :null => false
    add_column :applicants, :phone, :string, :null => false
  end

  def self.down
    remove_column :applicants, :phone
    remove_column :applicants, :address
  end
end
