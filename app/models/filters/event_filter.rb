# -*- encoding : utf-8 -*-
class EventFilter < WillFilter::Filter

  require 'date'
  
  def model_class
    Event
  end



  def default_filters
    [
      ["Helsinki Only", "helsinki_only"],
      ["Tallinn Only", "tallinn_only"],
      ["This year", "this_year"],
      ["Last year", "last_year"],
      ["Nilsiänkatu location", "nilsiankatu_location"]
    ]
  end

  def default_filter_conditions(key)
    if (key == "name_search") 
      return [:title, :contains, :text]
    end
    return [:location_id, :is, 1] if (key == "helsinki_only")
    return [:location_id, :is, 2] if (key == "tallinn_only")
    return [:place_id, :is, 1] if (key == 'nilsiankatu_location')
    if (key == 'this_year')
      return [:start_date, :is_in_the_range, [Date.new(Time.now.strftime("%Y").to_i, 1, 1), Date.new(Time.now.strftime("%Y").to_i, 31, 12)]] 
    end
  end

  def definition
    super.except(:id, :created_at, :updated_at)
  end
end
