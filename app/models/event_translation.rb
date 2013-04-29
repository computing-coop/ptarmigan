# -*- encoding : utf-8 -*-
class EventTranslation < ActiveRecord::Base
  validates_presence_of :event_id
end
