# -*- encoding : utf-8 -*-
ThinkingSphinx::Index.define :resource, :with => :active_record do
  indexes name, description, attachment_file_name
  has location_id, created_at, updated_at
end
