# -*- encoding : utf-8 -*-
class Admin::PodcastsController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!

  layout 'staff'
  
  def create
    @podcast = Podcast.new(params[:podcast])
    respond_to do |format|
      if @podcast.save
        flash[:notice] = 'Podcast was successfully created.'
        format.html { redirect_to admin_podcast_url(:id => @podcast.slug) }
        format.xml  { render :xml => @podcast, :status => :created, :location => @podcast }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @podcast.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @podcast.destroy
        flash[:notice] = 'Podcast was successfully destroyed.'        
        format.html { redirect_to admin_podcasts_path }
        format.xml  { head :ok }
      else
        flash[:error] = 'Podcast could not be destroyed.'
        format.html { redirect_to @podcast }
        format.xml  { head :unprocessable_entity }
      end
    end
  end
    
  def edit
    @podcast = Podcast.find(params[:id])
  end
  
  def new
    @podcast = Podcast.new
  end
  
  def index
    @podcasts = Podcast.page(params[:podcast])
  end


  def update
    @podcast = Podcast.find(params[:id])
    respond_to do |format|
      if @podcast.update_attributes(params[:podcast])
        flash[:notice] = 'Podcast was successfully updated.'
        format.html { redirect_to podcast_url(:id => @podcast.slug) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @podcast.errors, :status => :unprocessable_entity }
      end
    end
  end
    
    
end