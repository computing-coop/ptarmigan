class Calendarbackground < ApplicationRecord
  has_attached_file :image, styles:  {large: "1920x1080>",  medium: "1366x768>", small: "640x360>"},
                                         url: ':s3_domain_url',
                                          path:  "calendarbackgrounds/:id/:style/:normalized_resource_file_name"
   validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
    
  scope :active, -> () {where(active: true) }
  
  Paperclip.interpolates :normalized_resource_file_name do |attachment, style|
    attachment.instance.normalized_resource_file_name
  end

  before_save :extract_dimensions
  serialize :image_dimensions
  
  def normalized_resource_file_name
    return false unless image?
    "#{self.id}-#{self.image_file_name.gsub( /[^a-zA-Z0-9_\.]/, '_')}"
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
