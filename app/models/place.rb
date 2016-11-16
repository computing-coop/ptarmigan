# -*- encoding : utf-8 -*-
class Place < ActiveRecord::Base
  acts_as_nested_set
  has_many :events,  dependent: :delete_all
  has_many :instances
  has_and_belongs_to_many :locations
  geocoded_by :full_address
  reverse_geocoded_by :latitude, :longitude
  # acts_as_gmappable :process_geocoding => false
  has_many :postervotes
  attr_accessor :contact_email, :comment
  after_validation :maybe_geocode  
  validates_presence_of :city, :country
  accepts_nested_attributes_for :locations
  # include PublicActivity::Model
  # tracked owner: ->(controller, model) { controller.current_user }
  
  translates :name, fallbacks_for_empty_translations: true
  accepts_nested_attributes_for :translations, reject_if: proc { |attr| attr['name'].blank?  } 
  scope :tallinn, ->() { where(country: 'EE')}
  scope :for_events, ->() { where(allow_ptarmigan_events: true)}
  scope :creativeterritories, -> () { where(country: 'LV')}
  scope :creative_quarters, -> () { where(creative_quarters: true)}
  scope :other_venues, -> () { where(creative_quarters: false)}
  scope :approved_posters, -> () { where(approved_for_posters: true)}

  scope :events_between, ->(start_at, end_at) {
    creativeterritories.joins(:events).where(["date(events.date) >= ? and events.public = true and (events.enddate is null or date(events.enddate) <= ?)", start_at, end_at])
  }
  
  def address_or_coordinates
    if self.latitude.blank? || self.longitude.blank?
      geocode
    else
      reverse_geocode
    end
  end
  
  def to_mapjson
    {
      id: id,
      name: name,
      lat: latitude,
      lng: longitude
    }
  end
  
  
  def full_address
    "#{name}, #{address1}#{address2.blank? ? '' : ', ' + address2}, #{postcode} #{city}, #{country}"
  end

  def gmaps4rails_infowindow
    "<div class=\"place_title\">#{name}</div><div class=\"place_address\">#{full_address}</div>"
  end

  def icon
    'place.jpg'
  end
  
  def maybe_geocode
    if latitude.blank? && longitude.blank?
      geocode
    end
  end
  
  def votes_for
    postervotes.where(:vote => 1).size
  end
  
  def votes_against
    postervotes.where(:vote => -1).size
  end
  
end
