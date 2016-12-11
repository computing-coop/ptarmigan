class Ctad < ApplicationRecord
  has_attached_file :wide, :styles =>  {full: "1000x90#", thumb: "200x18>"},
            :url =>':s3_domain_url',
            path:  "ctads/:id/wide/:style/:normalized_resource_file_name", :default_url => "/assets/missing.png"
                                          

  has_attached_file :boxy, :styles =>  {full: "172x235#", thumb: "100x100>"},
    :url =>':s3_domain_url',
    path:  "ctads/:id/box/:style/:normalized_resource_file_name", :default_url => "/assets/missing.png"                                          

  validates_attachment_content_type :boxy, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates_attachment_content_type :wide, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  
  Paperclip.interpolates :normalized_resource_file_name do |attachment, style|
    attachment.instance.normalized_resource_file_name
  end
  before_save :extract_dimensions
  serialize :wide_dimensions
  serialize :boxy_dimensions
  
  scope :active, -> () { where(active: true) }
  scope :wide, ->() { where('wide_file_name is not null') }
  scope :box, ->() { where('boxy_file_name is not null') }
  
  def normalized_resource_file_name
    return false unless wide?
    "#{self.id}-#{self.wide_file_name.gsub( /[^a-zA-Z0-9_\.]/, '_')}"
  end  
  
  private

  # Retrieves dimensions for image assets
  # @note Do this after resize operations to account for auto-orientation.
  def extract_dimensions
    if wide?
      tempfile = wide.queued_for_write[:original]
      unless tempfile.nil?
        geometry = Paperclip::Geometry.from_file(tempfile)
        self.wide_dimensions = [geometry.width.to_i, geometry.height.to_i].join('x')
      end
    end
    if boxy?
      atmp = boxy.queued_for_write[:original]
      unless atmp.nil?
        geometry = Paperclip::Geometry.from_file(atmp)
        self.boxy_dimensions = [geometry.width.to_i, geometry.height.to_i].join('x')
      end
    end
  end
end
