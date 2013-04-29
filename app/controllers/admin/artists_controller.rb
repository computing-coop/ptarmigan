# -*- encoding : utf-8 -*-
class Admin::ArtistsController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :find_artist

  layout 'staff'
  has_scope :page, :default => 1

  
  def index
 	  @artists = Artist.page(params[:page]).per(200)
  end 
  
  def create
    @artist = Artist.new(params[:artist])
    respond_to do |format|
      if @artist.save
        flash[:notice] = 'Artist was successfully created.'
        format.html { redirect_to artist_url(:id => @artist) }
        format.xml  { render :xml => @artist, :status => :created, :location => @artist }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @artist.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @artist.destroy
        flash[:notice] = 'Artist was successfully destroyed.'        
        format.html { redirect_to artists_path }
        format.xml  { head :ok }
      else
        flash[:error] = 'Artist could not be destroyed.'
        format.html { redirect_to @artist }
        format.xml  { head :unprocessable_entity }
      end
    end
  end
  
  def edit
  end
  
  def new
    @artist = Artist.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @artist }
    end
  end

  def show
    redirect_to edit_admin_artist_path(params[:id])
  end

  def update
    respond_to do |format|
      if @artist.update_attributes(params[:artist])
        flash[:notice] = 'Artist was successfully updated.'
        format.html { redirect_to artist_path(:id => @artist.id) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @artist.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  private

  def find_artist 
    if params[:id]
      @artist = Artist.find(params[:id])
      
    end
  end
  
end
