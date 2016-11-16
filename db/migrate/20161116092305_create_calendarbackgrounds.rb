class CreateCalendarbackgrounds < ActiveRecord::Migration[5.0]
  def change
    create_table :calendarbackgrounds do |t|
      t.string :image_file_name
      t.integer :image_file_size, length: 8
      t.datetime :image_updated_at
      t.string :image_content_type
      t.string :image_dimensions
      t.boolean :active, null: false, default: false

      t.timestamps
    end
  end
end
