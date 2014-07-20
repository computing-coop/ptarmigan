# -*- encoding : utf-8 -*-
class Attendee < ActiveRecord::Base
  scope :event, proc { |event| where(:event_id => event) } 
  belongs_to :event
  default_scope order('created_at DESC')
  
  validates_presence_of :event_id, :name, :email
  validates_uniqueness_of :email, :scope => :event_id, :message => "address is already registered for this event.  Thanks!"
  before_destroy :update_waiting_list

  has_attached_file :filmstill, :styles => {:new_carousel => "960x400#", 
      :full => "600x400>", :small => "300x200#",
      :thumb => "100x100>" },
      :path =>  ":rails_root/public/images/users/attendees/filmstills/:id/:style/:normalized_filmstill_file_name",
      :url =>  "/images/users/attendees/filmstills/:id/:style/:normalized_filmstill_file_name", :default_url => "/assets/missing.png"

  has_attached_file :profile, :styles => {
      :full => "600x400>", :small => "300x200#",
      :thumb => "100x100#" },
      :path =>  ":rails_root/public/images/users/attendees/profiles/:id/:style/:normalized_profile_file_name",
      :url =>  "/images/users/attendees/profiles/:id/:style/:normalized_profile_file_name", :default_url => "/assets/missing.png"


  scope :by_event, ->(event_id) { where(:event_id => event_id) }
  scope :with_profile_pic, -> { where("profile_file_size > 0") }
  scope :approved, -> { where(approved: true)}
  attr_accessible :event_id, :comes_from, :approved, :optional, :work_in_progress_title, :event, :profile, :pay_received, :filmstill, :bio, :name, :email, :phone, :comments, :project_or_organisation, :profile, :invited
  
  after_create :send_notifications
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller.current_user }
  
  Paperclip.interpolates :normalized_filmstill_file_name do |attachment, style|
    attachment.instance.normalized_filmstill_file_name
  end
  Paperclip.interpolates :normalized_profile_file_name do |attachment, style|
    attachment.instance.normalized_profile_file_name
  end
  def icon
    if !profile_file_size.blank?
      profile.url(:thumb)
    else
      'attendee_icon.png'
    end
  end

  def send_notifications
    AttendeeMailer.registration_notification(self).deliver
    if event.is_full?
      AttendeeMailer.waitinglist_notification(self).deliver
    else
      AttendeeMailer.enduser_notification(self).deliver
    end
  end

  def update_waiting_list
    if event.is_full? && waiting_list == false
      n = Attendee.where(:waiting_list => true, :event_id => event.id).order(:created_at).first
      if !n.blank?
        n.waiting_list = false
        n.save!
        AttendeeMailer.deliver_waitinglist_notification(n)
      end
    end
  end
  def normalized_profile_file_name
    "#{self.id}-#{self.profile_file_name.gsub( /[^a-zA-Z0-9_\.]/, '_')}"
  end

  def normalized_filmstill_file_name
    "#{self.id}-#{self.filmstill_file_name.gsub( /[^a-zA-Z0-9_\.]/, '_')}"
  end

end
