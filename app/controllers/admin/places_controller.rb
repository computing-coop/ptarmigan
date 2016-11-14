# -*- encoding : utf-8 -*-
class Admin::PlacesController < Admin::BaseController
  before_action :find_place


  def create
    @place = Place.new(places_params)
    respond_to do |format|
      if @place.save
        flash[:notice] = 'Place was successfully created.'
        format.html { redirect_to admin_places_path  }
        format.xml  { render :xml => @place, :status => :created, :location => @place }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @place.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @place.destroy
        flash[:notice] = 'Place was successfully destroyed.'        
        format.html { redirect_to admin_places_path }
        format.xml  { head :ok }
      else
        flash[:error] = 'Place could not be destroyed.'
        format.html { redirect_to admin_places_path}
        format.xml  { head :unprocessable_entity }
      end
    end
  end

  def index
    if @subsite
      if @subsite.theme == 'creativeterritories'
        @places = Place.where(country: 'LV').order(:name)
      end
    end
    @places = Place.all if @places.nil?
    respond_to do |format|
      format.html
      format.xml  { render :xml => @places }
    end
  end

  def edit
  end

  def new
    @place = Place.new
    if @subsite
      if @subsite.name == 'creativeterritories'
        @place.country = 'LV'
      end
    end
    respond_to do |format|
      format.html
      format.xml  { render :xml => @place }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.xml  { render :xml => @place }
    end
  end

  def update
    respond_to do |format|
      if @place.update_attributes(places_params)
        flash[:notice] = 'Place was successfully updated.'
        format.html { redirect_to admin_places_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @place.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

  def find_place
    @place = Place.find(params[:id]) if params[:id]
  end
  
  protected

  def places_params 
    params.require(:place).permit( [:name, :address1, :address2, :city, :country, :postcode, :creative_quarters, :parent_id,  :map_url, :latitude, :longitude, :approved_for_posters, :allow_ptarmigan_eents, location_ids: [] ])
  end
  
end
