# -*- encoding : utf-8 -*-
class Chatter < ActiveRecord::Base
  has_many :comments
  belongs_to :user
  validates_presence_of :user_id, :subject
  has_attached_file :image, :styles => {:regular => "400x400>"},             
                              url: ':s3_domain_url',
                            path:  "chatter/:id/:style/:basename.:extension"

  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller.current_user }
    
  def latest
    if self.comments.any?
      self.comments.sort_by{|x| x.created_at }.reverse.first.created_at
    else
      self.created_at
    end
  end
  
  def title
    subject
  end
end
