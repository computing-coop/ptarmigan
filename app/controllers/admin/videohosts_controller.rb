# -*- encoding : utf-8 -*-
class Admin::VideohostsController < ApplicationController

  before_filter [:authenticate_user!, :find_videohost]

  VIDEOHOSTS_PER_PAGE = 20

  def create
    @videohost = Videohost.new(params[:videohost])
    respond_to do |format|
      if @videohost.save
        flash[:notice] = 'Videohost was successfully created.'
        format.html { redirect_to [:admin, @videohost] }
        format.xml  { render :xml => @videohost, :status => :created, :location => @videohost }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @videohost.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @videohost.destroy
        flash[:notice] = 'Videohost was successfully destroyed.'        
        format.html { redirect_to videohosts_path }
        format.xml  { head :ok }
      else
        flash[:error] = 'Videohost could not be destroyed.'
        format.html { redirect_to @videohost }
        format.xml  { head :unprocessable_entity }
      end
    end
  end

  def index
    @videohosts = Videohost.paginate(:page => params[:page], :per_page => VIDEOHOSTS_PER_PAGE)
    respond_to do |format|
      format.html
      format.xml  { render :xml => @videohosts }
    end
  end

  def edit
  end

  def new
    @videohost = Videohost.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @videohost }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.xml  { render :xml => @videohost }
    end
  end

  def update
    respond_to do |format|
      if @videohost.update_attributes(params[:videohost])
        flash[:notice] = 'Videohost was successfully updated.'
        format.html { redirect_to @videohost }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @videohost.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

  def find_videohost
    @videohost = Videohost.find(params[:id]) if params[:id]
  end

end
