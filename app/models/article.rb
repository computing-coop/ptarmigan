class Article < ApplicationRecord
  translates :name, :link_url, fallbacks_for_empty_translations: true
  belongs_to :location
  
  scope :by_location, -> (x) { where(['location_id = ?', x])}
  accepts_nested_attributes_for :translations, reject_if: proc { |attr| attr['name'].blank? || attr['link_url'].blank? } 
end
