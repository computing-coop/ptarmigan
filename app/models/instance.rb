class Instance < ActiveRecord::Base
  belongs_to :event
  belongs_to :place
  extend FriendlyId
  friendly_id :title_en, :use => [:slugged, :finders, :history]
  has_attached_file :specialimage, :styles => { :largest => "1280x800>", :medium => "400x400>",
                                       :thumb => "100x100>", :archive => "115x115#" },
             url: ':s3_domain_url',
        path: "events/instances/:id/:style/:basename.:extension"
  translates :special_information, :notes
  accepts_nested_attributes_for :translations, :reject_if => proc { |attributes| attributes['special_information'].blank? && attributes['notes'].blank? }
  validates_presence_of :event_id, :start_at, :end_at
  validates_attachment_content_type :specialimage, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"] 
  
  scope :future, -> () { where(['start_at >= ?', Time.now.to_date]).order(:date) }
  
  def as_json(options = {})
    {
      :id => self.id,
      :title => self.title.blank? ? self.event.title : self.title,
      :notes => self.event.notes,
      :place => self.event.place.name,
      :promoter => self.event.promoter.blank? ? "<br />" : "<br />by " +  self.event.promoter + "<br />",
      :description => self.special_information.blank? ? self.event.description : self.special_information,
      :start => start_at.strftime('%Y-%m-%d %H:%M:00'),
      :end => end_at.nil? ? start_at.strftime('%Y-%m-%d %H:%M:00') : end_at.strftime('%Y-%m-%d %H:%M:00'),
      :allDay => false, 
      :recurring => false,
      :url => self.title.blank? ? Rails.application.routes.url_helpers.event_path(self.event.slug) : 
        Rails.application.routes.url_helpers.event_instance_path(self.event.slug, self.title.parameterize)
      #:color => "red"
    }
  end
  
  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end
  
  def future?
    self.start_at >= Date.parse(Time.now.strftime('%Y/%m/%d'))
  end
  
  def title_en
       self.title.blank? ? self.id.to_s : self.title
  end
  
  def siblings
    event.instances.where(title: title)
  end
  
end
