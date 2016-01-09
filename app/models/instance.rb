class Instance < ActiveRecord::Base
  belongs_to :event
  
  has_attached_file :specialimage, :styles => { :largest => "1280x800>", :medium => "400x400>",
                                       :thumb => "100x100>", :archive => "115x115#" },
        :path =>  ":rails_root/public/images/events/instances/:id/:style/:basename.:extension", 
        :url => "/images/events/instances/:id/:style/:basename.:extension"
  translates :special_information
  accepts_nested_attributes_for :translations, :reject_if => proc { |attributes| attributes['special_information'].blank? }
  validates_presence_of :event_id, :start_at, :end_at
  validates_attachment_content_type :specialimage, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"] 
  
  def as_json(options = {})
    {
      :id => self.id,
      :title => self.event.title,
      :description => self.special_information.blank? ? self.event.description : self.special_information,
      :start => start_at.rfc822,
      :end => end_at.nil? ? start_at.rfc822 : end_at.rfc822,
      :allDay => false, 
      :recurring => false,
      :url => Rails.application.routes.url_helpers.event_path(event.slug),
      #:color => "red"
    }
  end
  
  def future?
    self.start_at >= Date.parse(Time.now.strftime('%Y/%m/%d'))
  end
end
