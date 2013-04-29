# -*- encoding : utf-8 -*-
ThinkingSphinx::Index.define :income, :with => :active_record do
  indexes recipient, what_for, source 
  has created_at, updated_at
end
