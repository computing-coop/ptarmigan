# -*- encoding : utf-8 -*-
class CreateApplicants < ActiveRecord::Migration
  def self.up
    create_table "applicants", :force => true do |t|
      t.column :login,                     :string, :limit => 40
      t.column :realname,                      :string, :limit => 100, :default => '', :null => true
      t.column :country_of_residence,                     :string, :limit => 100, :null => false
      t.column :nationality,               :string, :limit => 100, :null => false
      t.column :crypted_password,          :string, :limit => 40
      t.column :salt,                      :string, :limit => 40
      t.column :created_at,                :datetime
      t.column :updated_at,                :datetime
      t.column :remember_token,            :string, :limit => 40
      t.column :remember_token_expires_at, :datetime
      t.column :activation_code,           :string, :limit => 40
      t.column :activated_at,              :datetime

    end
    add_index :applicants, :login, :unique => true
  end

  def self.down
    drop_table "applicants"
  end
end
