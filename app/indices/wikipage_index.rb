# -*- encoding : utf-8 -*-
ThinkingSphinx::Index.define :wikipage, :with => :active_record do
  indexes title
  has created_at, updated_at
end
