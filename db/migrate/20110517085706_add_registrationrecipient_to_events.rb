# -*- encoding : utf-8 -*-
class AddRegistrationrecipientToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :registration_recipient, :string
    add_column :events, :registration_optional_q, :string
    add_column :attendees, :optional, :text
  end

  def self.down
    remove_column :events, :registration_recipient
    remove_column :events, :registration_optional_q
    remove_column :attendees, :optional
  end
end
