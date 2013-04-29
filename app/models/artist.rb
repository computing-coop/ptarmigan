# -*- encoding : utf-8 -*-
class Artist < ActiveRecord::Base
  paginates_per 4
  extend FriendlyId
  friendly_id :name, :use => :history
  has_many :events
  has_attached_file :avatar, :styles => { :new_carousel => "960x400#", :medium => "400x400>", :thumb => "100x100>" },
                               :path =>  ":rails_root/public/images/artists/:id/:style/:basename.:extension", 
                               :url => "/images/artists/:id/:style/:basename.:extension"
                               
  has_attached_file :carousel, :styles => {:new_carousel => "960x400#", :full => "600x400#", :small => "300x200#"}, 
                               :path =>  ":rails_root/public/images/carousel/artists/:id/:style/:basename.:extension", 
                               :url => "/images/carousel/artists/:id/:style/:basename.:extension"
  has_many :resources
  belongs_to :location
  translates :bio
  accepts_nested_attributes_for :translations, :reject_if => proc { |attributes| attributes['bio'].blank? }
  validates_presence_of :name, :location_id, :startdate, :enddate, :country
  scope :by_location, lambda {|x| {:conditions => {:location_id => x} }}
  scope :current, {:conditions => ["enddate >= ?", Time.now.strftime('%Y-%m-%d')]}
  scope :with_carousel, :conditions => ["carousel_file_name is not null AND carousel_file_size > 0" ]
  before_save :perform_avatar_removal 
  attr_accessor :remove_avatar, :remove_carousel
  attr_accessible :remove_avatar, :remove_carousel, :include_in_carousel, :location_id, :startdate, :enddate, :name, :country, :website1, :website2, :translations_attributes, :avatar, :carousel
  
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller.current_user }


  def icon
    avatar
  end
  
  def carousel_date
    dates_of_stay
  end

  def image
    carousel
  end

  def carousel_link
    self
  end

  def dates_of_stay
    [startdate, enddate]
  end
  
  def description
    bio
  end
  
  def perform_avatar_removal 
    self.avatar = nil if self.remove_avatar=="1" && !self.avatar.dirty? 
    self.carousel = nil if self.remove_carousel== "1" && !self.carousel.dirty?
    true 
  end   
  
end
