# -*- encoding : utf-8 -*-
ThinkingSphinx::Index.define :wikirevision, :with => :active_record do
  indexes contents
  has created_at, updated_at
end
