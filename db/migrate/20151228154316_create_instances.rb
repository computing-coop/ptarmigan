class CreateInstances < ActiveRecord::Migration
  def change
    create_table :instances do |t|
      t.integer :event_id, index: true, foreign_key: true
      t.datetime :start_at
      t.datetime :end_at
      t.string :specialimage_file_name
      t.integer :specialimage_file_size
      t.string :specialimage_content_type
      t.datetime :specialimage_updated_at

      t.timestamps null: false
    end
    Instance.create_translation_table! :special_information => :text
  end
end
