class CreateArticles < ActiveRecord::Migration[5.0]
  def self.up
    create_table :articles do |t|
      t.references :location, null: false, index: true
      t.timestamps
    end
    Article.create_translation_table! name: :string, link_url: :string
  end
  
  
  def self.down
    drop_table :articles
    Article.drop_translation_table!
    
  end
end
