class Subsite < ActiveRecord::Base
  belongs_to :location
  has_many :events
  # attr_accessible :fallback_theme, :name, :location_id, :human_name, :avatar, :carousel, :hide_from_carousel
  has_attached_file :avatar, :styles => {:new_carousel => "960x400#", :medium => "400x400>",
                                         :thumb => "100x100>" },
          :path =>  ":rails_root/public/images/subsites/:id/:style/:basename.:extension", 
        :url => "/images/subsites/:id/:style/:basename.:extension"

  has_attached_file :carousel, :styles => {:new_carousel => "960x400#", 
                :full => "600x400#", :small => "300x200#", :thumb => "100x100>"}, 
      :path =>  ":rails_root/public/images/subsites/projects/:id/:style/:basename.:extension",
      :url =>  "/images/carousel/subsites/:id/:style/:basename.:extension"

end
