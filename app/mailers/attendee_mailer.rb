# -*- encoding : utf-8 -*-
class AttendeeMailer < ActionMailer::Base

  def enduser_notification(attendee)
    @attendee = attendee
    @event = attendee.event
    @host = 'http://ptarmigan.' + @event.location.locale
    if @event.registration_recipient.blank?
      to_address = 'info@ptarmigan.' + @event.location.locale
    else
      to_address = @event.registration_recipient
    end
    mail(:to => attendee.email, :from => to_address, :subject => "#{t :confirmation}: #{@event.name}")
  end
  
  def registration_notification(attendee)
    @attendee = attendee
    @event = attendee.event
    @host = 'http://ptarmigan.' + @event.location.locale
    if @event.registration_recipient.blank?
      to_address = 'info@ptarmigan.' + @event.location.locale
      mail(:to => to_address, :from => "#{attendee.name} <#{attendee.email}>", :subject =>"[Ptarmigan attendee: #{@event.name}]" )
    else
      if @event.registration_recipient =~ /\,/
        recips = @event.registration_recipient.split(/,/)
        # recips.each do |recip|
          mail(:to => recips, :from => "#{attendee.name} <#{attendee.email}>", :subject =>"[Ptarmigan attendee: #{@event.name}]" )
        # end
      else
        mail(:to => @event.registration_recipient, :from => "#{attendee.name} <#{attendee.email}>", :subject =>"[Ptarmigan attendee: #{@event.name}]" )
      end
    end
    
  end
  
  def waitinglist_notification(attendee)
    @attendee = attendee
    @event = attendee.event
    @host = 'http://ptarmigan.' + @event.location.locale
    if @event.registration_recipient.blank?
      to_address = 'info@ptarmigan.' + @event.location.locale
    else
      to_address = @event.registration_recipient
    end
    mail(:to => attendee.email, :from => to_address, :subject => "#{t(:space_now_available)}: #{@event.name}")
  end

end
