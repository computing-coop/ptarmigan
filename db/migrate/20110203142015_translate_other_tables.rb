# -*- encoding : utf-8 -*-
class TranslateOtherTables < ActiveRecord::Migration
  def self.up
    Project.create_translation_table!({:description => :text})
    Project.all.each do |page|
      ProjectTranslation.create(:project_id => page.id, :locale => 'en', :description => page.description_en, :created_at => page.created_at, :updated_at => page.updated_at)
      ProjectTranslation.create(:project_id => page.id, :locale => 'fi', :description => page.description_fi, :created_at => page.created_at, :updated_at => page.updated_at)
    end
    rename_column :projects, :description_en, :description
    Artist.create_translation_table!({:bio => :text})
    Artist.all.each do |page|
      ArtistTranslation.create(:artist_id => page.id, :locale => 'en', :bio => page.bio_en, :created_at => page.created_at, :updated_at => page.updated_at)
      ArtistTranslation.create(:artist_id => page.id, :locale => 'fi', :bio => page.bio_fi, :created_at => page.created_at, :updated_at => page.updated_at)
    end
    rename_column :artists, :bio_en, :bio
  end

  def self.down
    rename_column :artists, :bio, :bio_en
    rename_column :project, :description, :description_en
    Artist.drop_translation_table!
    Project.drop_translation_table!
  end
end
