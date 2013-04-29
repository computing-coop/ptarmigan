# -*- encoding : utf-8 -*-
class Proposalcomment < ActiveRecord::Base
  belongs_to :proposal
  belongs_to :user
  attr_accessor :archived, :menuize
  before_save :check_accessors
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller.current_user } 

  after_create :send_notifications  

  def send_notifications
    ProposalcommentMailer.comment_notification(self).deliver
    if proposal.project_id == 35
       ProposalcommentMailer.comment_for_moks(self).deliver
    end
  end


  def check_accessors
    unless proposal.nil?
      self.comment += '<span class="comment_system">Proposal was archived.</span>' if self.archived == "1" && !(proposal.archived == true)
      self.comment += '<span class="comment_system">Proposal was added to staff "active" menu.</span>' if self.menuize == "1" && proposal.menuize == false
      self.comment += '<span class="comment_system">Proposal was un-archived.</span>' if self.archived == "0" && proposal.archived == true
      self.comment += '<span class="comment_system">Proposal was removed from staff "active" menu.</span>' if self.menuize == "0" && proposal.menuize == true      
      proposal.archived = self.archived
      proposal.menuize = self.menuize
      proposal.save!
    end
  end
  
  def icon
    'proposal_icon.jpg'
  end
end
