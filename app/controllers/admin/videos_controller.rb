# -*- encoding : utf-8 -*-
class Admin::VideosController < ApplicationController

  before_filter :authenticate_user!
  before_filter :find_video
  layout 'staff'
  has_scope :page, :default => 1

  def create
    @video = Video.new(params[:video])
    respond_to do |format|
      if @video.save
        flash[:notice] = 'Video was successfully created.'
        format.html { redirect_to [:admin, @video] }
        format.xml  { render :xml => @video, :status => :created, :location => @video }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @video.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @video.destroy
        flash[:notice] = 'Video was successfully destroyed.'        
        format.html { redirect_to videos_path }
        format.xml  { head :ok }
      else
        flash[:error] = 'Video could not be destroyed.'
        format.html { redirect_to @video }
        format.xml  { head :unprocessable_entity }
      end
    end
  end

  def index
    @videos = Video.order('created_at DESC').page(params[:page]).per(40)
    respond_to do |format|
      format.html
      format.xml  { render :xml => @videos }
    end
  end

  def edit
  end

  def new
    @video = Video.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @video }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.xml  { render :xml => @video }
    end
  end

  def update
    respond_to do |format|
      if @video.update_attributes(params[:video])
        flash[:notice] = 'Video was successfully updated.'
        format.html { redirect_to @video }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @video.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

  def find_video
    @video = Video.find(params[:id]) if params[:id]
  end

end
