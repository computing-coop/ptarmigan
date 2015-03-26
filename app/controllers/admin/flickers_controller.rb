# -*- encoding : utf-8 -*-
class Admin::FlickersController < InheritedResources::Base
  has_scope :event
  has_scope :page, :default => 1
  respond_to :html, :js, :xml, :json
  before_filter :authenticate_user!
  before_filter :exclude_guests
  before_filter :find_flicker
  layout 'staff'
  load_and_authorize_resource
  has_scope :page, :default => 1
  
  def create
    @flicker = Flicker.new(params[:flicker])
    respond_to do |format|
      if @flicker.save
        flash[:notice] = 'Flickers was successfully created.'
        format.html { redirect_to [:admin, @flicker] }
        format.xml  { render :xml => @flicker, :status => :created, :location => @flickers }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @flicker.errors, :status => :unprocessable_entity }
      end
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
    respond_to do |format|
      if @flicker.update_attributes(params[:flickers])
        flash[:notice] = 'Flickers was successfully updated.'
        format.html { redirect_to [:admin, @flicker] }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @flicker.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

  def find_flicker
    @flicker = Flicker.find(params[:id]) if params[:id]
  end

end
