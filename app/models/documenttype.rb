class Documenttype < ActiveRecord::Base
  attr_accessible :name
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller.current_user }  
end
