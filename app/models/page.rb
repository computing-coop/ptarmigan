# -*- encoding : utf-8 -*-
class Page < ActiveRecord::Base
  belongs_to :location
  belongs_to :subsite
  scope :by_location, lambda {|x| {:conditions => {:location_id => x} }}
  scope :by_subsite, lambda{|x| {:conditions => {:subsite_id => x } } }
  translates :title, :excerpt, :body
  attr_accessible :location_id, :location, :subsite, :subsite_id, :translations_attributes, :carousel, :slug
  accepts_nested_attributes_for :translations, :reject_if => proc { |attributes| attributes['title'].blank? && attributes['body'].blank? && attributes['abstract'].blank? }
  validates_presence_of :slug
  validates_uniqueness_of :slug, :scope => :subsite_id
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller.current_user }

  has_attached_file :carousel, :styles => {:new_carousel => "960x400#", 
    :full => "600x400>", :small => "300x200#",
    :thumb => "100x100>" },
    :path =>  ":rails_root/public/images/carousel/pages/:id/:style/:normalized_resource_file_name",
    :url =>  "/images/carousel/pages/:id/:style/:normalized_resource_file_name", :default_url => "/assets/missing.png"

  Paperclip.interpolates :normalized_resource_file_name do |attachment, style|
    attachment.instance.normalized_resource_file_name
  end

  def icon
    'staticpage_icon.png'
  end

  def name
    title
  end
  
  def description
    body
  end

  def normalized_resource_file_name
    "#{self.id}-#{self.carousel_file_name.gsub( /[^a-zA-Z0-9_\.]/, '_')}"
  end

end
