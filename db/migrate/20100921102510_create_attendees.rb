# -*- encoding : utf-8 -*-
class CreateAttendees < ActiveRecord::Migration
  def self.up
    create_table :attendees do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :pay_received
      t.references :event
      t.text :comments
      
      t.timestamps
    end
    add_column :events, :registration_required, :boolean, :null => false, :default => false
    add_column :events, :registration_limit, :integer
  end
  
  def self.down
    drop_table :attendees
  end
end
