# -*- encoding : utf-8 -*-
ThinkingSphinx::Index.define :expense, :with => :active_record do
  indexes what_for, recipient, paid_by
  has created_at, updated_at
end
