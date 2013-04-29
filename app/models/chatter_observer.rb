# -*- encoding : utf-8 -*-
class ChatterObserver < ActiveRecord::Observer
  def after_create(chatter)
    ChatterMailer.deliver_chatter_notification(chatter)
  end


end
