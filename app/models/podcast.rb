class Podcast < ActiveRecord::Base
  belongs_to :event
  attr_accessible :cloudfront_filename, :description, :name, :number, :published, :event_id, :file_length
  extend FriendlyId
  friendly_id :number_and_name, :use => :history
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller.current_user }  
  validates_presence_of :number, :name, :cloudfront_filename, :file_length
  
  
  scope :published, :conditions => {:published => true }
    
  def icon
    'podcast_icon.png'
  end
  
  def feed_date
    created_at
  end
  
  def number_and_name
    "#{number}-#{name}"
  end
  
  def location
    false
  end


  def title
    number_and_name
  end
  
  def subsite
    false
  end
  
  def rss_description(locale)
    description
  end
end
