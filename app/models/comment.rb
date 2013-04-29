# -*- encoding : utf-8 -*-
class Comment < ActiveRecord::Base
  belongs_to :chatter
  belongs_to :user
  validates_presence_of :user_id
  has_attached_file :image, :styles => {:regular => "600x600>"},             
                            :path =>  ":rails_root/public/images/comments/:id/:style/:basename.:extension",
                            :url =>  "/images/comments/:id/:style/:basename.:extension"

  attr_accessor :menuize
  after_save :set_menuize

  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller.current_user }
    
  def set_menuize
    if chatter
      chatter.menuize = self.menuize
      chatter.save!
    end
  end

end
