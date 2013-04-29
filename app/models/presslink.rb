# -*- encoding : utf-8 -*-
class Presslink < ActiveRecord::Base
  belongs_to :project
  belongs_to :artist
  belongs_to :event
  belongs_to :location
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller.current_user }
    
end
