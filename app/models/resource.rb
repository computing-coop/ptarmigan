# -*- encoding : utf-8 -*-
class Resource < ActiveRecord::Base

  belongs_to :project, optional: true
  belongs_to :artist, optional: true
  belongs_to :event, optional: true
  # validates_presence_of :documenttype_id, :name
  belongs_to :documenttype, optional: true
  validates :attachment, :attachment_presence => true
  scope :by_location, lambda {|x| {:conditions => {:location_id => x} }}
  has_attached_file :attachment, :whiny => false,
                           url: ':s3_domain_url',
                       path: "attachments/:id/:style/:basename.:extension"
  has_attached_file :icon, :styles => { :medium => "400x400>", :thumb => "100x100>" },
                                   url: ':s3_domain_url',
                        path: "icons/:id/:style/:normalized_resource_file_name", :default_url => "/assets/missing.png"
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller.current_user }
  scope :by_location, -> (x) { where(location_id: x) }
  validates_attachment_content_type :icon, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates :attachment, attachment_presence: true

  Paperclip.interpolates :normalized_resource_file_name do |attachment, style|
    attachment.instance.normalized_resource_file_name
  end



  def normalized_resource_file_name
    "#{self.id}-#{self.icon_file_name.gsub( /[^a-zA-Z0-9_\.]/, '_')}"
  end

  def document_name
    name
  end

  def document_type_name
    documenttype.nil? ? 'undefined' : documenttype.name
  end

  def source_resource
    item.nil? ? nil : item
  end

  def source_name
    item.nil? ? nil : item.try(:name)
  end

  def item
    if !event_id.nil?
      event
    elsif !project_id.nil?
      project
    elsif !artist_id.nil?
      artist
    else
      nil
    end
  end

  def location
    self.location_id.nil? ? item_location : Location.find(self.location_id)
  end

  def item_location
    self.item.nil? ? nil : item.location
  end
end
