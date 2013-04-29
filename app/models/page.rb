# -*- encoding : utf-8 -*-
class Page < ActiveRecord::Base
  belongs_to :location
  scope :by_location, lambda {|x| {:conditions => {:location_id => x} }}
  translates :title, :excerpt, :body
  accepts_nested_attributes_for :translations, :reject_if => proc { |attributes| attributes['title'].blank? && attributes['body'].blank? && attributes['abstract'].blank? }
  validates_presence_of :slug
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller.current_user }
  
  def icon
    'staticpage_icon.png'
  end

  def name
    title
  end
  
  def description
    body
  end
   
end
