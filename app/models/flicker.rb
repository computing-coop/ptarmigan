# -*- encoding : utf-8 -*-
class Flicker < ActiveRecord::Base
  belongs_to :event
  scope :event, proc { |event| where(:event_id => event) } 
  attr_accessible :include_in_carousel, :event_id, :image_file_name, :image_file_size, :is_video, :name, :creator, :hostid, :image, :description,  :image_content_type
  has_attached_file :image, 
                    :path =>  ":rails_root/public/images/contrib/:id/:style/:basename.:extension", 
                    :url => "/images/contrib/:id/:style/:basename.:extension",
                    :styles => {:largest => "1180x492#", :new_carousel => "960x400#", :larger => "800x600>", :cropped => "600x400#", 
                      :standard => "500x375>", :medium => "320x200#", 
                      :front_sidebar => "72x72#"}

  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller.current_user }
  
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
      [event.date]
    else
      [event.date, event.enddate]
    end
  end
end
