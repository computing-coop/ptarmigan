class CreateSubsites < ActiveRecord::Migration
  def change
    create_table :subsites do |t|
      t.string :name
      t.string :fallback_theme
      t.references :location
      t.string :carousel_file_name
      t.string :carousel_content_type
      t.date :carousel_updated_at
      t.integer :carousel_file_size
      t.string :avatar_file_name
      t.string :avatar_content_type
      t.date :avatar_updated_at
      t.integer :avatar_file_size

      t.timestamps
    end
    add_index :subsites, :location_id
  end
end
