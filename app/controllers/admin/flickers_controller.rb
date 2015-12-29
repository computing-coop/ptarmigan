# -*- encoding : utf-8 -*-
class Admin::FlickersController < Admin::BaseController
  has_scope :event
  has_scope :page, :default => 1
  respond_to :html, :js, :xml, :json

  before_filter :find_flicker

  
  def create
    @flicker = Flicker.new(flicker_params)
    if @flicker.save
      respond_with @flicker, location: admin_flickers_path
    end
  end

  def destroy
    respond_to do |format|
      if @flicker.destroy
        flash[:notice] = 'Flickers was successfully destroyed.'        
        format.html { redirect_to admin_flickers_path }
        format.xml  { head :ok }
      else
        flash[:error] = 'Flickers could not be destroyed.'
        format.html { redirect_to @flicker }
        format.xml  { head :unprocessable_entity }
      end
    end
  end

  def index
    @flickers = Flicker.by_location(@location.id).page(params[:page]).per(100)
  end

  def edit
  end

  def new
    @flicker = Flicker.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @flicker }
    end
  end

  def remove_carousel
    @flicker = Flicker.find(params[:id])
    @flicker.include_in_carousel = false
    @flicker.save
    respond_to do |format|
      format.js
    end
  end

  def set_carousel
    @flicker = Flicker.find(params[:id])
    @flicker.include_in_carousel = true
    @flicker.save
    respond_to do |format|
      format.js
    end
  end
  def show
    require 'flickraw'
    respond_to do |format|
      format.html
      format.xml  { render :xml => @flicker }
    end
  end

  def update
    if @flicker.update_attributes(flicker_params)
      respond_with @flicker, location: admin_flickers_path
    end
  end

  private

  def find_flicker
    @flicker = Flicker.find(params[:id]) if params[:id]
  end

  protected
  
  def flicker_params
    params.require(:flicker).permit([:description, :image, :event_id, :hostid, :is_video, :include_in_carousel, :creator])
  end
  
end
