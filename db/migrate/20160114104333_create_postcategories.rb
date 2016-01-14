class CreatePostcategories < ActiveRecord::Migration
  def up
    create_table :postcategories do |t|

      t.timestamps null: false
    end
    Postcategory.create_translation_table! :name => :string
    Postcategory.create([translations_attributes: [ {locale: 'en', name: 'News'},  {locale: 'fi', name: 'Uutiset'}, {locale: 'sv', name: 'Nyheter'} ]] )
    Postcategory.create([translations_attributes: [ {locale: 'en', name: 'Blog'} , {locale: 'fi', name: 'Blogi'},   {locale: 'sv', name: 'Blogg'} ]] )
  end
  
  def down
    drop_table :postcategories
    Postcategory.drop_translation_table!
  end
end
