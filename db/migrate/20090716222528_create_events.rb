# -*- encoding : utf-8 -*-
class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.date :date
      t.string :title
      t.string :promoter
      t.string :type
      t.text :description_fi
      t.text :description_en
      t.float :cost
      t.text :metadata_fi
      t.text :metadata_en
      t.string :avatar_file_name
      t.string :avatar_content_type
      t.integer :avatar_file_size
      t.datetime :avatar_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
