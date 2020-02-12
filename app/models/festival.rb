class Festival < ApplicationRecord
  extend FriendlyId
  translates :description, fallbacks_for_empty_translations: true
  friendly_id :name, use: [:slugged, :finders, :history]
  has_many :events
  accepts_nested_attributes_for :translations, reject_if: proc { |attr| attr['description'].blank?  } #|| attr['description'].blank? }
  validates_date :end_at, after: :start_at
end
