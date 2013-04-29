# -*- encoding : utf-8 -*-
ThinkingSphinx::Index.define :event, :with => :active_record do
  indexes translations.title, :as => :title
  indexes translations.description, :as => :description
  has location_id, created_at, updated_at
end
