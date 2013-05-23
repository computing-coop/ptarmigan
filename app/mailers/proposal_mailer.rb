# -*- encoding : utf-8 -*-
class ProposalMailer < ActionMailer::Base

  def proposal_notification(proposal)
    case proposal.location
      when "0"
        location = 'Tallinn + Helsinki'
      when "1"
        location = 'Helsinki'
      when "2" 
        location = 'Tallinn'
    end
    @proposal = proposal
    @location = location
    @host = 'http://ptarmigan.fi'
    mail(:to => 'info@ptarmigan.fi', :from => proposal.email, :subject =>"[Ptarmigan proposal: #{location}]" )
  end

  def email_to_moks(proposal)
    case proposal.location
      when "0"
        location = 'Tallinn + Helsinki'
      when "1"
        location = 'Helsinki'
      when "2" 
        location = 'Tallinn'
    end
    @proposal = proposal
    @location = location
    @host = 'http://ptarmigan.fi'
    mail(:to => ['moks@moks.ee', 'siiri@moks.ee', 'jg@maaheli.ee'], :from => "john@ptarmigan.ee", :subject =>"[Axis of Praxis proposal: #{proposal.name}]" )    
  end

end
