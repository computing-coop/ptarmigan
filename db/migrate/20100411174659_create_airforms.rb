# -*- encoding : utf-8 -*-
class CreateAirforms < ActiveRecord::Migration
  def self.up
    create_table :airforms do |t|
      t.text :project_summary
      t.text :detailed_description
      t.text :events
      t.text :equipment
      t.references :applicant, :null => false
      t.text :budget
      t.boolean :jul_aug
      t.boolean :sept_oct
      t.boolean :nov_dec
      t.boolean :submitted, :default => false, :null => false
      t.string :cv_file_name
      t.integer :cv_file_size
      t.string :cv_content_type
      t.datetime :cv_updated_at
      t.string :attachment_file_name
      t.integer :attachment_file_size
      t.string :attachment_content_type
      t.datetime :attachment_updated_at
      t.boolean :terms_agreed, :default => false, :null => false
      
      t.timestamps
    end
  end
  
  def self.down
    drop_table :airforms
  end
end
