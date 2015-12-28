# -*- encoding : utf-8 -*-
class Place < ActiveRecord::Base
  has_many :events
  geocoded_by :full_address
  reverse_geocoded_by :latitude, :longitude
  # acts_as_gmappable :process_geocoding => false
  has_many :postervotes
  attr_accessor :contact_email, :comment
  after_validation :maybe_geocode  
  validates_presence_of :city, :country
  
  # include PublicActivity::Model
  # tracked owner: ->(controller, model) { controller.current_user }
    
  scope :for_events, -> { where(allow_ptarmigan_events: true)}
  scope :creativeterritories, -> { where(country: 'LV')}
  scope :approved_posters, -> { where(approved_for_posters: true)}

  def address_or_coordinates
    if self.latitude.blank? || self.longitude.blank?
      geocode
    else
      reverse_geocode
    end
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
