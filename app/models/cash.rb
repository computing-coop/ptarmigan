# -*- encoding : utf-8 -*-
class Cash < ActiveRecord::Base
  
  scope :tiib_events_on,  lambda { |*args| { :conditions => 
      ['source = "tiib" AND (cast(link_url as date) = ? OR (cast(link_url as date) <= ? AND cast(content as date) >= ?))', args.first, args.first, args.first] }
  }

   scope :scorestore_events_on,  lambda { |*args| { :conditions => 
      ['source = "scorestore" AND (cast(link_url as date) = ? OR (cast(link_url as date) <= ? AND cast(content as date) >= ?))', args.first, args.first, args.first] }
  }
 

  
end
