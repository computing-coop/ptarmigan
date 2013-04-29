# -*- encoding : utf-8 -*-
class Place < ActiveRecord::Base
  has_many :events  

  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller.current_user }
    
  def full_address
    "#{name}, #{address1}#{address2.blank? ? '' : ', ' + address2}, #{postcode} #{city}, #{country}"
  end
end
