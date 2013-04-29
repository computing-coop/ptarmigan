# -*- encoding : utf-8 -*-
class Video < ActiveRecord::Base
  belongs_to :videohost
  belongs_to :event
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller.current_user }  
end
