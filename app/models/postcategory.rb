class Postcategory < ActiveRecord::Base
  has_and_belongs_to_many :posts
  translates :name
  accepts_nested_attributes_for :translations, reject_if: proc {|x| x['name'].blank? }
end
