# -*- encoding : utf-8 -*-
class Attendee < ActiveRecord::Base
  scope :event, proc { |event| where(:event_id => event) } 
  belongs_to :event
  default_scope :order => 'created_at DESC'
  
  validates_presence_of :event_id, :name, :email
  validates_uniqueness_of :email, :scope => :event_id, :message => "address is already registered for this event.  Thanks!"
  before_destroy :update_waiting_list

  after_create :send_notifications
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller.current_user }
  
  def icon
    'attendee_icon.png'
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

end
