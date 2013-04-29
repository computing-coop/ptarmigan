# -*- encoding : utf-8 -*-
class Location < ActiveRecord::Base
  has_many :events


  def city_name
    name == 'Suomi' ? 'Helsinki' : 'Tallinn'
  end
end
