class Podcast < ActiveRecord::Base
  belongs_to :event
  attr_accessible :cloudfront_filename, :description, :name, :number, :published, :event_id
  extend FriendlyId
  friendly_id :number_and_name, :use => :history
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller.current_user }  
  validates_presence_of :number, :name, :cloudfront_filename
  
  scope :published, :conditions => {:published => true }
    
  def icon
    'podcast_icon.png'
  end
  
  def number_and_name
    "#{number}-#{name}"
  end

end
