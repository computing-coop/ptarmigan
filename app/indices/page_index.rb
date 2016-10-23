# -*- encoding : utf-8 -*-
ThinkingSphinx::Index.define :page, :with => :active_record do
  indexes translations.title, as: :title
  indexes translations.body, as: :body
  has location_id, created_at, updated_at
end
