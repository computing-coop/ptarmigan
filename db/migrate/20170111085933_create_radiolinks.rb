class CreateRadiolinks < ActiveRecord::Migration[5.0]
  def self.up
    create_table :radiolinks do |t|
      t.string :link_url
      t.references :location, null: false, index: true
      t.timestamps
    end
    Radiolink.create_translation_table! name: :string
  end
  
  def self.down
    drop_table :radiolinks
    Radiolink.drop_translation_table!
  end
end
