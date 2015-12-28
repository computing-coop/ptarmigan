# -*- encoding : utf-8 -*-
class Location < ActiveRecord::Base
  has_many :events
  has_and_belongs_to_many :places


  def city_name
    name == 'Suomi' ? 'Helsinki' : 'Tallinn'
  end
  
  def available_places
    Place.where(:country => locale.downcase)
  end
end
