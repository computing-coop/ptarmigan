class CreateFestivals < ActiveRecord::Migration[5.1]
  def change
    create_table :festivals do |t|
      t.string :name
      t.string :slug
      t.date :start_at
      t.date :end_at
      t.text :custom_css

      t.timestamps
    end
    Festival.create_translation_table! description: :text
    add_column :events, :festival_id, :integer
    add_index :events, :festival_id
  end


  def self.down
    drop_table :festivals
    Festival.drop_translation_table!
    remove_column :events, :festival_id
  end

end
