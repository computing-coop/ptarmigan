class CreatePodcasts < ActiveRecord::Migration
  def change
    create_table :podcasts do |t|
      t.string :number
      t.string :name
      t.references :event
      t.string :cloudfront_filename
      t.boolean :published
      t.text :description
      t.string :slug
      t.timestamps
    end
    add_index :podcasts, :event_id
  end
end
