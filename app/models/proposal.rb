# -*- encoding : utf-8 -*-
class Proposal < ActiveRecord::Base
  has_many :proposalcomments
  belongs_to :project
  validates_presence_of :name, :location, :short_description, :duration, :cost
  validates :email, :presence => true, 
                      :length => {:minimum => 3, :maximum => 254},
                      :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}
  
  has_attached_file :attachment
  validates_attachment_size :attachment, :less_than => 5.megabytes, 
     :unless => Proc.new {|model| model.attachment }
     
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller.current_user }
  
  after_create :send_notifications  

  def send_notifications
    ProposalMailer.proposal_notification(self).deliver
    if project_id == 35
       ProposalMailer.email_to_moks(self).deliver
    end
  end


  def icon
    'proposal_icon.jpg'
  end

  def title 
    name
  end
  
  def project_name
    project.nil? ? "" : project.name
  end
  
end
