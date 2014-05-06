# -*- encoding : utf-8 -*-
class Budgetarea < ActiveRecord::Base
  has_many :expenses
  scope :active, where(:active => true)
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller.current_user }
   
  def icon
    'expense_icon.png' 
  end
end
