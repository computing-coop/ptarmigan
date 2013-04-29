# -*- encoding : utf-8 -*-
class CommentMailer < ActionMailer::Base
  def comment_notification(comment)
    @comment = comment
    @host = 'http://ptarmigan.fi'
    mail(:to => 'board@ptarmigan.fi',  :cc => 'kimmo.modig@gmail.com',:from => "#{comment.user.name} <#{comment.user.email}>", :subject =>"[New comment on thread: #{comment.chatter.subject}] ")

  end
  
  

end
