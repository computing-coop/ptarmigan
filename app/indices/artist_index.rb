# -*- encoding : utf-8 -*-
ThinkingSphinx::Index.define :artist, :with => :active_record do
  indexes name, bio
  has location_id, created_at, updated_at
end
