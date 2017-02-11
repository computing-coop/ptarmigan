class Carouselvideo < ApplicationRecord
  belongs_to :location
  belongs_to :subsite

  has_attached_file :stillimage, :styles =>  {:largest => "1600x712#",    :new_carousel => "1600x712#", :full => "960x427", :small => "320x143#", :thumb => "100x100>"},
                                 :url =>':s3_domain_url',
                                 path:  "carousel/videos/:id/:style/:normalized_resource_file_name", :default_url => "/assets/missing.png"
  
  translates :title, :subtitle, fallbacks_for_empty_translations: true
  accepts_nested_attributes_for :translations, :reject_if => proc { |attributes| attributes['title'].blank?  }
  scope :by_location, -> (x) { where(['location_id = ?', x])}
  scope :by_subsite, -> (x) { where(:subsite_id => x) }
  validates_attachment_content_type :stillimage, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  
  def carousel_image?
    stillimage_content_type =~ %r{^(image|(x-)?application)/(bmp|gif|jpeg|jpg|pjpeg|png|x-png)$}
  end
  
  def normalized_resource_file_name
    return false unless carousel_image?
    "#{self.id}-#{self.stillimage_file_name.gsub( /[^a-zA-Z0-9_\.]/, '_')}"
  end  
  
end
