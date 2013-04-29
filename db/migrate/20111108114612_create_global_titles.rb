# -*- encoding : utf-8 -*-
class CreateGlobalTitles < ActiveRecord::Migration
  def self.up
    add_column :event_translations, :title, :string
    rename_column :events, :title, :oldtitle
    Event.all.each do |event|
      event.translations.each do |et|
        et.title = event.oldtitle
        et.save!
      end
    end
  end

  def self.down
    rename_column :events, :oldtitle, :title
    remove_column :event_translations, :title
  end
end
