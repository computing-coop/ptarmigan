class RemoveBlankTranslations < ActiveRecord::Migration
  def change
    Event.all.each do |e|
      e.translations.each do |t|
        if t.title.blank? && t.description.blank? && t.notes.blank?
          t.destroy!
        end
      end
    end
    
    Post.all.each do |p|
      p.translations.each do |t|
        if t.title.blank? && t.body.blank?
          t.destroy!
        end
      end
    end
  end
end
