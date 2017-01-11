class Radiolink < ApplicationRecord
  belongs_to :location
  translates :name, fallbacks_for_empty_translations: true
  accepts_nested_attributes_for :translations, reject_if: proc { |attr| attr['name'].blank? }
  scope :by_location, -> (x) { where(['location_id = ?', x])}
end
