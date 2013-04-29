# -*- encoding : utf-8 -*-
class AttendeeObserver < ActiveRecord::Observer
  def after_create(attendee)
    AttendeeMailer.deliver_registration_notification(attendee)
    AttendeeMailer.deliver_enduser_notification(attendee)
  end




end
