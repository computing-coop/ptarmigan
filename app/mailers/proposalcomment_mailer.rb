# -*- encoding : utf-8 -*-
class ProposalcommentMailer < ActionMailer::Base
  def comment_notification(proposalcomment)
    case proposalcomment.proposal.location
      when "0"
        location = 'Tallinn + Helsinki'
      when "1"
        location = 'Helsinki'
      when "2" 
        location = 'Tallinn'
    end
    @location = location
    @proposalcomment = proposalcomment
    @host = 'http://ptarmigan.fi'
    mail(:to => ['tallinn@ptarmigan.ee', 'helsinki@ptarmigan.fi'], :from => "#{proposalcomment.user.name} <#{proposalcomment.user.email}>", :subject =>"[New comment on proposal: #{proposalcomment.proposal.name} (#{location})] ")
  end
  
  def comment_for_moks(proposalcomment)
    case proposalcomment.proposal.location
      when "0"
        location = 'Tallinn + Helsinki'
      when "1"
        location = 'Helsinki'
      when "2" 
        location = 'Tallinn'
    end
    @location = location
    @proposalcomment = proposalcomment
    @host = 'http://ptarmigan.fi'
    mail(:to => ['moks@moks.ee', 'siiri@moks.ee', 'jg@maaheli.ee'], :from => "#{proposalcomment.user.name} <#{proposalcomment.user.email}>", :subject =>"[New comment on proposal: #{proposalcomment.proposal.name} (#{location})] ")
  end

end
