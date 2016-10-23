# -*- encoding : utf-8 -*-
class Flicker < ActiveRecord::Base
  belongs_to :event
  scope :event, -> (e) {  where(:event_id => e) } 
  # attr_accessible :include_in_carousel, :event_id, :image_file_name, :image_file_size, :is_video, :name, :creator, :hostid, :image, :description,  :image_content_type
  has_attached_file :image, 
                         url: ':s3_domain_url',
                    path: "contrib/:id/:style/:basename.:extension",
                    :styles => {:largest => "1600x712#", 
    :new_carousel => "1200x533#", :full => "960x427", :small => "320x143#",
     :thumb => "100x100>"}, :default_url => "/assets/missing.png"

  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller.current_user }
  delegate :location, :to => :event, :allow_nil => false
  
  scope :by_location, -> (loc) { joins(:event).where("events.location_id = ?", loc)}
  
  validates_presence_of :event_id
    validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  def carousel_link
    event
  end
  
  def icon
    image.url(:front_sidebar)
  end


  def name
    event.name
  end

  def carousel_date
    if event.enddate.blank?
      [event.date.to_date]
    else
      if event.date.to_date == event.enddate.to_date
        [event.date.to_date]
      else
        [event.date.to_date, event.enddate.to_date]
      end
    end
  end
end
