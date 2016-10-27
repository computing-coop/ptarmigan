# -*- encoding : utf-8 -*-
class Project < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name_and_location, :use => :history
  has_many :events
  belongs_to :location
  has_attached_file :avatar, :styles => {:new_carousel => "960x400#", :medium => "400x400>", :thumb => "100x100>" },
               url: ':s3_domain_url',
        path: "/projects/:id/:style/:basename.:extension", :default_url => "/assets/missing.png"
  has_attached_file :carousel, :styles => {:largest => "1180x492#",
                                          :new_carousel => "960x400#", :full => "600x400#", :small => "300x200#", :thumb => "100x100>"},
                                            url: ':s3_domain_url',
                          path: "/carousel/projects/:id/:style/:basename.:extension"
  has_many :resources
  translates :description
  accepts_nested_attributes_for :translations, :reject_if => proc { |attributes| attributes['description'].blank? }
  validates_presence_of :name
  scope :by_location, -> (x) { where(location_id: x) }
  scope :proposable, -> () { where(proposable: true ) }
  scope :active, -> () {   where(:active => true )}
  scope :with_carousel, -> () {  where(["active is true AND carousel_file_name is not null AND carousel_file_size > 0" ]) }
  before_save :perform_avatar_removal 
  attr_accessor :remove_avatar, :remove_carousel
  # attr_accessible :include_in_carousel,:translations_attributes, :avatar, :carousel, :location_id, :name, :website1, :website2, :remove_avatar, :remove_carousel, :active, :proposable, :hidden
  
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller.current_user }


  def self.active_menu(location)
    active = Project.by_location(location).where(:active => true).order(:name).map{|x| [x.name, x.slug]}
    inactive = Project.by_location(location).where(:active => false).order(:name).map{|x| [x.name, x.slug]}
    other = Project.where("location_id <> #{location}").where(:active => true).order(:name).map{|x| [x.name, x.slug]}
    otherinactive = Project.where("location_id <> #{location}").where(:active => true).order(:name).map{|x| [x.name, x.slug]}    
    return [" --- " + Location.find(location).name + " --- "] + active + [" --- " + Location.where("id <> #{location}").first.name + " --- "] + other + [' --- inactive --- '] + inactive  + otherinactive
  end 

  def icon
    avatar
  end

  def carousel_link
    self
  end

  def carousel_date
    date
  end

  
  def date
    if active == true
      []
    else
      if events.blank?
        []
      else 
        [events.sort_by(&:date).first.date, events.sort_by(&:date).last.date]
      end
    end
  end

  def perform_avatar_removal 
    self.avatar = nil if self.remove_avatar=="1" && !self.avatar.dirty? 
    self.carousel = nil if self.remove_carousel== "1" && !self.carousel.dirty?
    true 
  end 
  
  def image
    carousel
  end

  def name_and_location
    "#{location.name}-#{name}"
  end
  
end
