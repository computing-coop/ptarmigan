# -*- encoding : utf-8 -*-
class Admin::PlacesController < ApplicationController

  before_filter :authenticate_user!
  before_filter :find_place
  layout 'staff'

  PLACES_PER_PAGE = 20

  def create
    @place = Place.new(params[:place])
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
    @places = Place.page(params[:page]).per(50)
    respond_to do |format|
      format.html
      format.xml  { render :xml => @places }
    end
  end

  def edit
  end

  def new
    @place = Place.new
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
      if @place.update_attributes(params[:place])
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

end
