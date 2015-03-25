class Eventcategory < ActiveRecord::Base
  translates :name, fallbacks_for_empty_translations: true
  extend FriendlyId
  friendly_id :name_en, :use => :history
  accepts_nested_attributes_for :translations, :reject_if => proc { |attributes| attributes['name'].blank?  }
  
  def name_en
    self.name(:en).blank? ? self.translations.first.name : self.name(:en)
  end
 
end
