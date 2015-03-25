class CreateEventcategories < ActiveRecord::Migration
  def self.up
    create_table :eventcategories do |t|
      t.string :colour
      t.string :slug
      t.timestamps
    end
    Eventcategory.create_translation_table! name: :string
    add_column :events, :event_time, :time
  end
  
  def self.down
    drop_table :eventcategories
    Eventcategory.drop_translation_table! 
    remove_column :events, :event_time
  end
  
end
