# -*- encoding : utf-8 -*-
class Cash < ActiveRecord::Base
  
  has_attached_file :image, :styles => { :standard => "1080x1080#", :low => "320x320#", :thumbnail => "150x150#"},
        :path =>  ":rails_root/public/images/social_cache/:id/:style/:basename.:extension", 
        :url => "/images/social_cache/:id/:style/:basename.:extension", :default_url => "/assets/missing.png"
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  
  
  # scope :tiib_events_on  lambda { |*args| { :conditions =>
  #     ['source = "tiib" AND (cast(link_url as date) = ? OR (cast(link_url as date) <= ? AND cast(content as date) >= ?))', args.first, args.first, args.first] }
  # }
  #
  #  scope :scorestore_events_on,  lambda { |*args| { :conditions =>
  #     ['source = "scorestore" AND (cast(link_url as date) = ? OR (cast(link_url as date) <= ? AND cast(content as date) >= ?))', args.first, args.first, args.first] }
  # }
 scope :by_location, -> (x) { where(['location_id = ?', x])}
 scope :by_source, -> (x) { where(['source = ?', x])}
 
 before_save :extract_dimensions
 serialize :image_dimensions
  
 def image_height
   if image?
     width, height = image_dimensions.split('x')
     return height.to_i
   else
     return 0
   end
 end
 
 def image_width
   if image?
     width, height = image_dimensions.split('x')
     return width.to_i
   else
     return 0
   end
 end
 
 private

 # Retrieves dimensions for image assets
 # @note Do this after resize operations to account for auto-orientation.
 def extract_dimensions
   if image?
     tempfile = image.queued_for_write[:original]
     unless tempfile.nil?
       geometry = Paperclip::Geometry.from_file(tempfile)
       self.image_dimensions = [geometry.width.to_i, geometry.height.to_i].join('x')
     end
   end
 end

   
end
