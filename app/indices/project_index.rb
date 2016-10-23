# -*- encoding : utf-8 -*-
ThinkingSphinx::Index.define :project, :with => :active_record do
  indexes name, sortable: true
  indexs translations.description, as: :description
  has location_id, created_at, updated_at
end
