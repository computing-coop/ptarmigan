class PlacesController < ActionController::Base
  theme 'kuulutused'
  def show
    @place = Place.find(params[:id])
  end
  
end