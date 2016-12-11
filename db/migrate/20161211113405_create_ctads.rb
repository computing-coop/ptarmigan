class CreateCtads < ActiveRecord::Migration[5.0]
  def change
    create_table :ctads do |t|
      t.boolean :active
      t.text :notes
      t.string :wide_file_name
      t.integer :wide_file_size, length: 11
      t.string :wide_content_type
      t.datetime :wide_updated_at
      t.string :boxy_file_name
      t.integer :boxy_file_size, length: 11
      t.string :boxy_content_type
      t.datetime :boxy_updated_at
      t.string :boxy_dimensions
      t.string :wide_dimensions
      t.string :name
      t.string :link_url
      t.timestamps
    end
  end
end
