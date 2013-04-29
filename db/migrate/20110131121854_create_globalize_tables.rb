# -*- encoding : utf-8 -*-
class CreateGlobalizeTables < ActiveRecord::Migration
  def self.up

    Page.create_translation_table!({:title => :string, :body => :text, :excerpt => :text})
    Page.all.each do |page|
      PageTranslation.create(:page_id => page.id, :locale => 'en', :excerpt => page.abstract_en, :body => page.body_en, :title => page.title_en, :created_at => page.created_at, :updated_at => page.updated_at)
      PageTranslation.create(:page_id => page.id, :locale => 'fi', :excerpt => page.abstract_fi, :body => page.body_fi, :title => page.title_fi, :created_at => page.created_at, :updated_at => page.updated_at)
    end
    rename_column :pages, :title_en, :title
    rename_column :pages, :abstract_en, :excerpt
    rename_column :pages, :body_en, :body
    

    Event.create_translation_table! :description => :text, :notes => :text
    Event.all.each do |event|
      EventTranslation.create(:event_id => event.id, :locale => 'en', :notes => event.notes, :description => event.description, :created_at => event.created_at, :updated_at => event.updated_at)
      EventTranslation.create(:event_id => event.id, :locale => 'fi', :notes => event.metadata_fi, :description => event.description_fi, :created_at => event.created_at, :updated_at => event.updated_at)
    end
    rename_column :events, :description_en, :description
    rename_column :events, :metadata_en, :notes
  end

  def self.down
    rename_column :pages, :title, :title_en
    rename_column :pages, :excerpt, :abstract_en
    rename_column :pages, :body, :body_en
    Page.drop_translation_table! 
    rename_column :events, :description, :description_en
    rename_column :events, :notes, :metadata_en
    Event.drop_translation_table!
  end
end
