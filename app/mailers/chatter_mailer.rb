# -*- encoding : utf-8 -*-
class ChatterMailer < ActionMailer::Base

  def chatter_notification(chatter)
    @chatter = chatter
    @host = 'http://ptarmigan.fi'
    mail(:to => 'info@ptarmigan.fi', :cc => 'kimmo.modig@gmail.com', :from => "#{chatter.user.name} <#{chatter.user.email}>", :subject =>"[Ptarmigan chatter: #{chatter.subject}]" )

  end

end
