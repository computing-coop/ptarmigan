# -*- encoding : utf-8 -*-
ThinkingSphinx::Index.define :wikifile, :with => :active_record do
  indexes description, attachment_file_name
  has created_at, updated_at
end
