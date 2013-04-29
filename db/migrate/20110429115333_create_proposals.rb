# -*- encoding : utf-8 -*-
class CreateProposals < ActiveRecord::Migration
  def self.up
    create_table :proposals do |t|
      t.string :location
      t.string :name
      t.string :organisation
      t.string :email
      t.string :address
      t.string :country
      t.string :phone_number
      t.text :short_description
      t.string :duration
      t.text :long_description
      t.text :public_engagement
      t.text :materials
      t.text :spatial_requirements
      t.text :cost
      t.text :bio
      t.text :urls
      t.text :ptarmigan_goodfit

      t.timestamps
    end
  end

  def self.down
    drop_table :proposals
  end
end
